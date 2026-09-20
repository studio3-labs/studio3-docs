# CLAUDE.md - Studio3 Documentation Project

## Project Overview

This project creates a comprehensive 50+ page MkDocs + Material documentation site for Studio3, a venture building platform that uses gamified belief signals, public milestones, and community validation to help startups grow from idea to sovereignty.

## Key Concepts

### Platform Philosophy
- **Studio3** is a venture engine where "belief becomes momentum"
- Startups are built through public **Arenas** with transparent milestones
- **NOT** an incubator, accelerator, or traditional DAO
- Gamified entrepreneurship with real rewards and real, permanent consequences

### Core Mechanics

#### 1. Signals, Forecasts and Rewards (there is NO token)
Studio3 has **no native token**. `$SIGNAL` was removed in September 2026 and must never be
reintroduced. `lint_markdown_ultra.py` carries a guard that reports an error for `$SIGNAL` or
`$STUDIO` in `docs/`, and that guard now runs on every pull request
(`.github/workflows/pr-checks.yml`), from the Makefile, and from the pre-commit hooks. Run it
yourself with `make lint-tokens`, or `python3 lint_markdown_ultra.py --token-guard docs`. The full
linter is `make lint`; see `LINTING.md` for the rest.

- **Signal**: a FREE protocol action answering "what do you think we should do?" - yes/no, A or B,
  a preference. Costs nothing, never scored, equal weight for every participant.
- **Forecast**: also FREE and separate, answering "what do you think WILL happen?" - a probability.
  Scored against the verified outcome and built into a personal accuracy record.
- **Prediction market**: OPTIONAL, EXTERNAL (Polymarket) and RARE. Per-venture switchable,
  unavailable in many jurisdictions, and money only ever attaches to a Forecast, never a Signal.
  Never describe a market as required, native, or as how Studio3 works.
- **Rewards**: real **USDC** plus non-cash items (merch, access, tickets, credits, digital
  collectibles), granted through **Drops** and **Bounties**, held by the Arena and released on
  success.
- **Verification**: Studio3 staff at launch; Anchors take over later.
- **Progression titles**: novice, adept, expert, master, legend - earned from verified outcomes,
  forecast accuracy and delivered bounties, NEVER from points, staking or holdings. There is no XP.
- **Failure is public and permanent.** Objectives can fail and the record says so.

**Not yet decided, so never describe:** how escrow custody works, what a Grand Arena prize legally
is, and the exact proportions by which a reward is split between contributors. Say only that the
Sender proposes the split, contributors can dispute, and an Anchor arbitrates.

**Not yet built:** Drops, Bounties, evidence submission and Arena-held escrow. Write about the
model, not about features a reader could use today.

#### 2. Three NFT System
- **Spark NFT** 🎨: Original idea, created from remixed IP-NFTs via Flambette marketplace
- **Signal NFT** 📡: Dynamic venture identity, tracks entire journey
- **Halo NFT** 🛡️: Soulbound sovereignty seal, unlocked only at exit

#### 3. Container DAO Model
- Lightweight governance wrapper for each venture
- Houses all NFTs in a **Genesis Wallet** (multisig)
- Enables community participation without equity dilution
- Progressive decentralization as venture grows

#### 4. Seven Phase Lifecycle
1. **Spark** ✨: Ideas enter and gather initial belief
2. **Forge** ⚔️: Founders compete in duels for ownership
3. **Ignition** 🚀: Container DAO forms, MVP development
4. **Drift** 🌊: Find product-market fit through iteration
5. **Orbit** 🛸: Achieve stable operations
6. **Flare** 🔥: Scale with capital and growth
7. **Ascension** 🎖️: Graduate to full sovereignty

### Three Roles
- **Founders (Senders)**: Build ventures through public milestones
- **Supporters (Echoes)**: Signal belief/doubt and forecast outcomes, both free; accuracy builds a public record, rewards come from Drops and Bounties
- **Validators (Anchors)**: Guide ventures and validate progress

## Technical Architecture

### Documentation Stack
```
MkDocs + Material Theme
├── Custom CSS animations (Signal Orb, Arena Cards)
├── Interactive JavaScript components
├── Mermaid diagram support
├── Responsive design with dark/light modes
└── Search, navigation, and TOC integration
```

### Key Files
- `mkdocs.yml`: Main configuration with navigation structure
- `generate_docs.py`: Python script to generate all content
- `docs/stylesheets/extra.css`: Custom styling for Studio3 branding
- `docs/javascripts/extra.js`: Interactive components

## Important Implementation Notes

### Language & Framing
- **NEVER** write `$SIGNAL` or `$STUDIO` - Studio3 has no native token
- **NEVER** use odds, stakes, payouts, bets, wagering, burns, multipliers, XP, staking, bankroll
  or "belief and doubt markets"
- **KEEP** the arena drama and energy: Arenas, Senders, Anchors, Echoes, Grand Arenas and the
  seven venture phases all keep their character
- **EMPHASIZE** belief/doubt as conviction about execution, expressed for free
- **AVOID** mentioning the underlying Echion protocol
- **FOCUS** on Studio3 as the user-facing platform

### Content Priorities
1. **Practical guides** over technical theory
2. **Visual examples** with Arena cards and phase indicators
3. **Clear progression paths** for each role
4. **Real rewards and consequences** in the gamified system
5. **Community-driven validation** as core principle

### Style Guidelines
- Use **arena-card** class for important callouts
- Put **pure HTML** inside `arena-card` divs and omit `markdown="1"` - `lint_markdown_ultra.py`
  flags an arena-card that has both. Use `markdown="1"` only on the outer `grid`/`grid cards`
  wrapper.
- Apply **phase-indicator** classes with appropriate colors
- Include **emoji indicators** for visual navigation
- Maintain **conversational but authoritative** tone

**Never run Prettier over `docs/`.** It does not understand MkDocs admonitions and reflows the
four-space body onto the `!!!` line, which breaks published pages. `docs/` is in
`.prettierignore`, no check or hook runs Prettier on it, and there is no auto-formatter for the
documentation - `lint_markdown_ultra.py` reports, you fix by hand. See `LINTING.md`.

## Project Structure

```
studio3-docs/
├── docs/
│   ├── getting-started/     # Introduction and basics
│   ├── arena/              # Arena system mechanics
│   ├── lifecycle/          # 7-phase journey details
│   ├── nfts/              # NFT system explanation
│   ├── founders/          # Founder-specific guides
│   ├── echoes/            # Supporter guides
│   ├── anchors/           # Validator guides
│   ├── tools/             # Platform features
│   ├── cases/             # Success stories
│   └── resources/         # Templates and FAQ
├── mkdocs.yml             # Configuration
├── generate_docs.py       # Content generator
└── improvement_commands.sh # Expansion scripts
```

## Key Interactions

### Arena Flow
```mermaid
graph LR
    A[Milestone Declared] --> B[Echoes Signal]
    B --> C[Work Period]
    C --> D[Validation]
    D --> E[Rewards/Penalties]
```

### NFT Evolution
1. **Spark Phase**: Spark NFT minted from remixed IPs
2. **Forge Phase**: Winner receives Signal NFT
3. **Ignition Phase**: Halo NFT created in Genesis Wallet
4. **Ascension Phase**: All NFTs bought back for sovereignty

### Technology Readiness Levels (TRL)
- Maps each phase to TRL 1-9 progression
- Provides clear maturity indicators
- Guides appropriate milestone setting

## Common Patterns

### Successful Ventures
- Clear problem definition from remixed IPs
- Realistic milestone progression
- Active community engagement
- Consistent delivery record
- Strategic use of doubt signals for improvement

### Arena Best Practices
- Declare specific, measurable milestones
- Engage with both belief and doubt signals
- Iterate based on community feedback
- Build reputation through consistency
- Graduate through all phases systematically

## Edge Cases & Considerations

### Milestone Failures
- The reward the Arena holds is not released
- The failure is recorded publicly and permanently
- Failed ventures can pivot in Drift phase
- Resurrection Duels allow second chances

### Signal Dynamics
- Signalling and forecasting cost nothing, so participation has no financial barrier
- Early forecasts count for more on a personal accuracy record
- Contrarian correct forecasts are worth more than consensus ones
- Herd behavior shows up as poor calibration
- Anchor opinions carry significant weight

### Exit Mechanics
- Buyback requires repurchasing Spark + Signal NFTs
- Halo NFT only unlocks after complete buyback
- Genesis Wallet ownership transfers to founders
- Graduated ventures can launch sub-studios

## Future Enhancements

### Planned Features
- Conditional signals ("I think we should, if...")
- Advanced Arena types
- Recursive studio creation
- Enhanced analytics dashboard

### Documentation Expansion
- Video tutorials for each role
- Interactive Arena simulator
- Real-time venture tracker
- Community contribution system
- Multi-language support

## Debugging Tips

### Common Issues
1. **Missing content**: Run `python3 generate_docs.py`
2. **Styling broken**: Check `extra.css` is loaded
3. **Navigation errors**: Verify `mkdocs.yml` structure
4. **Search not working**: Rebuild with `mkdocs build`

### Performance Optimization
- Minimize custom CSS animations on mobile
- Lazy load images and heavy components
- Use static generation for production
- Enable caching headers

## Related Systems

### Flambette Marketplace
- Source of remixable IP-NFTs
- Integration point for Spark creation
- Browse research and patents
- Combine IPs into venture concepts
- Bridge to **Caelum Protocol** for IP financing and fractionalization
- Enables IP-NFT fractions to be assembled into Spark NFTs

### MindfulTech Institute
- Circle of founders focused on collaborative learning
- Bridge to **Aletheia Protocol** for trust infrastructure
- Uses **Koras** (trust hubs) for founder verification
- Facilitates recruiting and HR through **Traces** (verifiable credentials)
- Helps ventures build trusted teams with verified backgrounds
- Provides mentorship networks with authenticated expertise

### At Bryde Ud Ecosystem
- Meta-protocol coordination layer
- Rewards cross-protocol interactions
- Studio3 operates independently within it
- $BRYDE governance (background only)

### Protocol Touchpoints
- **Aletheia Integration**: Trust verification for founders and team members via MindfulTech
- **Caelum Integration**: IP financing and fractionalization through Flambette
- These remain mostly invisible to users but enhance Studio3's capabilities

## Success Metrics

### Documentation Goals
- 50+ comprehensive pages
- Clear role-based navigation
- Interactive examples throughout
- Mobile-responsive design
- Fast search and loading

### User Success Indicators
- Quick understanding of core concepts
- Clear path to participation
- Reduced support questions
- High engagement with guides
- Successful venture launches

---

**Remember**: Studio3 is about making belief matter through transparent, gamified venture building. The documentation should inspire participation while clearly explaining the mechanics and rewards.
