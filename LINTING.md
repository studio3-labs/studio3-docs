# Studio3 Documentation Linting Guide

This document describes the validation that actually runs on this repository.

Until September 2026 it described a linter that was not here. `LINTING.md`, the `Makefile`,
`package.json` and `.pre-commit-config.yaml` all named `lint_markdown.py` or
`lint_markdown_strict.py`, and neither file exists. The only linter in the repository is
`lint_markdown_ultra.py`. Everything below names that file.

## Overview

Two tools validate the documentation:

1. **`lint_markdown_ultra.py`** - the custom markdown linter, including the dead-token guard
2. **`mkdocs build --strict`** - structural and navigation problems

Prettier is **not** one of them. It is installed, but `docs/` is in `.prettierignore` and no
command, hook or check runs it over the documentation. [Why Prettier does not format
`docs/`](#why-prettier-does-not-format-docs) explains what happens if you point it there anyway.

There is no auto-formatter for `docs/`. `lint_markdown_ultra.py` reports formatting problems;
you fix them by hand.

## Quick Commands

```bash
make validate      # everything below, in one go

make lint          # custom linter over docs/
make lint-tokens   # dead-token guard only
make lint-strict   # mkdocs --strict

make build         # build the site (with PDFs)
make serve         # local development server
make install       # set up the virtualenv and npm dependencies
```

## The dead-token guard

Studio3 has no native token. `$SIGNAL` was removed in September 2026 and must never be
reintroduced, and `$STUDIO` must not appear either. `lint_markdown_ultra.py` carries that rule and
can run it on its own:

```bash
python3 lint_markdown_ultra.py --token-guard docs
```

It exits non-zero if either name appears anywhere under `docs/`, and it runs on every pull
request. The rule has one definition in the code - `check_dead_tokens()` - which both
the full linter and `--token-guard` call, so the two can never drift apart.

## Custom markdown linter

```bash
python3 lint_markdown_ultra.py            # all of docs/ (the default)
python3 lint_markdown_ultra.py docs       # same, explicitly
python3 lint_markdown_ultra.py FILE ...   # only the named files
python3 lint_markdown_ultra.py --token-guard docs
```

A path may be a file or a directory; directories are searched recursively for `*.md`. Passing no
path checks all of `docs/`. The linter exits 1 when it finds errors and is pure standard library,
so it needs no virtualenv.

### Issues detected

1. **Bold formatting** - unclosed `**`, stray spaces inside bold markers
2. **List formatting** - missing blank line before a list, double markers, odd indentation
3. **Arena cards** - `markdown="1"` on an `arena-card` that contains HTML, nested divs, unclosed divs
4. **Dead token names** - `$SIGNAL` or `$STUDIO` anywhere
5. **Structure** - skipped header levels, unclosed code blocks, malformed tables and links
6. **Whitespace** - multiple consecutive spaces, too many blank lines

## Why Prettier does not format `docs/`

**Do not add Prettier back to the documentation path.** Not to the pull-request checks, not to
`package.json`, not to `.pre-commit-config.yaml`, not to the `Makefile`. `docs/` is listed in
`.prettierignore` and that entry is load-bearing.

These pages are MkDocs-flavoured Markdown. An MkDocs admonition carries its body in a
four-space-indented block under the `!!!` line:

```markdown
!!! success "Flare Playbook"
    1. **Prove Unit Economics** - Show profitable growth potential
    2. **Build Investor Pipeline** - Leverage Studio3 network
```

That indentation is not standard Markdown, so Prettier does not recognise the construct. It strips
the indentation and reflows the body onto the `!!!` line:

```markdown
!!! success "Flare Playbook" 1. **Prove Unit Economics** - Show profitable growth potential 2. **Build Investor Pipeline** - Leverage Studio3 network
```

The Flare Playbook stops being a list, and the same happens to "Winning the Forge" and the other
phase admonitions in `docs/overview-guide/seven-phases.md`, and to admonitions across the rest of
the site. A single `prettier --write 'docs/**/*.md'` breaks published pages, silently.

This cannot be configured away. It is not a `printWidth` or `proseWrap` problem - Prettier has no
concept of the syntax, so there is no setting that makes it safe. The fix is scope, not options:
Prettier stays out of `docs/`.

`.prettierrc` and the Prettier dependency remain for ad-hoc use on files outside `docs/`. Because
`docs/` is in `.prettierignore`, even `npx prettier --write docs/` is a no-op.

## MkDocs strict mode

```bash
make lint-strict
```

Catches missing files referenced in navigation, broken internal links, invalid YAML and plugin
errors. The warn/error behaviour is configured under `validation:` in `mkdocs.yml`.

## Automated validation

### Pull requests

`.github/workflows/pr-checks.yml` runs on every pull request. Every check is a hard failure:

| Check | Scope | What it does |
| --- | --- | --- |
| **Build site** | whole repo | `make install` then `make build`, the same path the deploy workflow uses |
| **Dead-token guard** | **all of `docs/`** | `lint_markdown_ultra.py --token-guard docs` |
| **Lint and format changed docs** | files the PR changes | `lint_markdown_ultra.py`, on changed `docs/**/*.md` only |

The third check is deliberately scoped to changed files. The repository carries pre-existing debt -
60 linter errors across four files - so gating whole-repository lint would fail every pull request
on problems nobody in it introduced. Running the linter in a mode that cannot fail would be worse:
it would look like evidence while proving nothing. Changed-files-only gates new work honestly and
leaves the existing debt visible and tracked separately.

That check also used to run `prettier --check` on the changed files. It was removed. Every file
under `docs/` failed `prettier --check`, so the step failed for any pull request that touched any
existing page, and the only way to satisfy it was to run `prettier --write` and break the
admonitions. See [Why Prettier does not format `docs/`](#why-prettier-does-not-format-docs).

### Deploys

`.github/workflows/deploy.yml` builds and publishes to GitHub Pages on push to `main`. It does not
run on pull requests; that is what `pr-checks.yml` is for.

### Pre-commit hooks

```bash
pip install pre-commit
pre-commit install
```

`.pre-commit-config.yaml` runs the custom linter over the staged markdown files, the dead-token
guard over all of `docs/`, and the usual whitespace and YAML hygiene hooks. It does **not** run
Prettier: a hook that rewrites files after the author has read them is the worst place to put a
formatter that breaks admonitions.

## Known debt

Not introduced by current work, and not fixed by the pull-request checks:

- 60 linter errors in `docs/senders-guide/{founder-basics,milestone-planning,requirements,winning-strategies}.md`

Tracked as its own work. Do not fix it incidentally inside an unrelated pull request.

The "77 files fail `prettier --check`" item is **not** debt and is not scheduled work. Those files
are correct MkDocs; Prettier is the wrong tool for them. See
[Why Prettier does not format `docs/`](#why-prettier-does-not-format-docs).

## Extending the linter

Add a check method to `UltraMarkdownLinter` and call it from `lint_file()`:

```python
def check_new_rule(self, lines):
    errors = []
    for i, line in enumerate(lines):
        if 'pattern' in line:
            errors.append((i + 1, "Rule violation", line))
    return errors
```

Each check returns `(line_number, message, line)` tuples. If a rule needs to run on its own as a
CI gate, give it a method of its own - as `check_dead_tokens()` does - so there is only ever one
definition of it.

## Troubleshooting

1. **`source: command not found`** - use bash: `bash -c "source venv/bin/activate"`
2. **MkDocs plugins not found** - run `make install`
3. **A pull request fails "Lint and format changed docs"** - run
   `python3 lint_markdown_ultra.py <the files you changed>` and fix what it reports by hand.
   There is no auto-formatter for `docs/`; do not reach for `prettier --write`.
4. **A pull request fails the dead-token guard** - remove `$SIGNAL` / `$STUDIO`; see `CLAUDE.md`
   for the wording to use instead
