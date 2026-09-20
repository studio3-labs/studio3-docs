# Studio3 Documentation Linting Guide

This document describes the validation that actually runs on this repository.

Until September 2026 it described a linter that was not here. `LINTING.md`, the `Makefile`,
`package.json` and `.pre-commit-config.yaml` all named `lint_markdown.py` or
`lint_markdown_strict.py`, and neither file exists. The only linter in the repository is
`lint_markdown_ultra.py`. Everything below names that file.

## Overview

Three tools validate the documentation:

1. **`lint_markdown_ultra.py`** - the custom markdown linter, including the dead-token guard
2. **Prettier** - consistent markdown formatting
3. **`mkdocs build --strict`** - structural and navigation problems

## Quick Commands

```bash
make validate      # everything below, in one go

make lint          # custom linter over docs/
make lint-tokens   # dead-token guard only
make lint-strict   # mkdocs --strict
make format-check  # Prettier, check only
make format        # Prettier, apply

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

## Prettier

```bash
make format-check   # check
make format         # apply
```

Configuration is in `.prettierrc` (`printWidth: 100`, `proseWrap: preserve`) and `.prettierignore`.

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
| **Lint and format changed docs** | files the PR changes | Prettier `--check` and the custom linter, on changed `docs/**/*.md` only |

The third check is deliberately scoped to changed files. The repository carries pre-existing debt -
60 linter errors across four files, and Prettier failures in all 77 files under `docs/` - so gating
whole-repository lint would fail every pull request on problems nobody in it introduced. Running
the tools in a mode that cannot fail would be worse: it would look like evidence while proving
nothing. Changed-files-only gates new work honestly and leaves the existing debt visible and
tracked separately.

### Deploys

`.github/workflows/deploy.yml` builds and publishes to GitHub Pages on push to `main`. It does not
run on pull requests; that is what `pr-checks.yml` is for.

### Pre-commit hooks

```bash
pip install pre-commit
pre-commit install
```

`.pre-commit-config.yaml` runs Prettier, the custom linter over the staged markdown files, the
dead-token guard over all of `docs/`, and the usual whitespace and YAML hygiene hooks.

## Known debt

Not introduced by current work, and not fixed by the pull-request checks:

- 60 linter errors in `docs/senders-guide/{founder-basics,milestone-planning,requirements,winning-strategies}.md`
- Prettier formatting failures in all 77 files under `docs/`

Both are tracked as their own work. Do not fix them incidentally inside an unrelated pull request;
reformatting 77 files makes every other change unreviewable.

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
3. **A pull request fails "Lint and format changed docs"** - run `make format`, then
   `python3 lint_markdown_ultra.py <the files you changed>` and fix what it reports
4. **A pull request fails the dead-token guard** - remove `$SIGNAL` / `$STUDIO`; see `CLAUDE.md`
   for the wording to use instead
