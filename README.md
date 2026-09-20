# Studio3 Documentation

Comprehensive documentation for Studio3, a revolutionary venture building platform that transforms how startups are created, funded, and grown through transparent milestones, community validation, and gamified progression.

## 📖 About Studio3

Studio3 is a next-generation venture building ecosystem where **belief becomes momentum**. Unlike traditional incubators or accelerators, Studio3 creates a transparent, gamified environment where:

- **🚀 Founders (Senders)** build ventures in public through seven progressive phases, from initial Spark to full Ascension
- **📡 Supporters (Echoes)** signal what a venture should do and forecast what it will do - both free - building a public accuracy record
- **⚓ Validators (Anchors)** guide ventures and verify milestone completion, ensuring ecosystem quality

### Key Innovation: The Three-NFT System

Every venture in Studio3 is represented by three unique NFTs:
- **Spark NFT** 🎨 - The original idea, created from remixed intellectual property
- **Signal NFT** 📡 - Dynamic identity tracking the venture's entire journey
- **Halo NFT** 🛡️ - Soulbound sovereignty seal, unlocked only at successful exit

### Why Studio3 Matters

- **Transparent Building**: All development happens in public with clear milestones
- **Community Validation**: Collective wisdom prevents failures and accelerates success
- **Aligned Incentives**: Everyone wins when ventures succeed - no zero-sum games
- **Progressive Funding**: Capital flows based on proven execution, not just promises
- **True Ownership**: Founders can achieve full sovereignty through the buyback process

## 🌐 Live Documentation

Visit the full documentation at: [https://inocult.github.io/studio3-docs/](https://inocult.github.io/studio3-docs/)

## 📚 Documentation Structure

The documentation is organized into four main guides:

### 1. **Overview Guide**
- Introduction to Studio3 ecosystem
- Core concepts and principles
- Seven-phase lifecycle explanation
- Three-role system overview
- Rewards and consequences

### 2. **Senders Guide** (Founders)
- Complete handbook for venture builders
- From Spark creation to Ascension
- Milestone planning and execution
- Community engagement strategies
- Exit and buyback processes

### 3. **Echoes Guide** (Supporters)
- Signal and forecast mechanics
- Building an accuracy record
- Venture evaluation frameworks
- Rewards and recognition
- Community participation

### 4. **Anchors Guide** (Validators)
- Validation frameworks and standards
- Mentorship best practices
- Quality criteria and red flags
- Governance participation
- Reputation building

## 🛠️ Technical Stack

- **Static Site Generator**: [MkDocs](https://www.mkdocs.org/)
- **Theme**: [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- **Hosting**: GitHub Pages
- **PDF Generation**: WeasyPrint with custom styling
- **Markdown Linting**: Custom ultra-strict linter
- **Code Formatting**: Prettier

## 🚀 Local Development

### Prerequisites
- Python 3.8+
- Node.js 18+
- Make (build automation)
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/inocult/studio3-docs.git
cd studio3-docs
```

2. Install all dependencies:
```bash
make install
```

This will:
- Create a Python virtual environment
- Install Python dependencies
- Install Node.js dependencies

### Available Commands

Run `make help` to see all available commands:

```bash
make help         # Show all available commands
make serve        # Start local development server
make build        # Build documentation with PDFs
make lint         # Run markdown linter
make format       # Format markdown files
make pdfs         # Generate PDF guides only
make clean        # Clean build artifacts
make validate     # Run all validation checks
```

### Running Locally

Start the development server:
```bash
make serve
```

Visit `http://localhost:8000` to see the documentation.

### Building the Site

Build documentation with PDFs:
```bash
make build
```

The built site will be in the `site/` directory.

## 📄 PDF Generation

PDF guides are automatically generated during the build process. To generate PDFs only:
```bash
make pdfs
```

PDFs will be available in `docs/pdf/`:
- `studio3-overview-guide.pdf` - Complete ecosystem overview
- `studio3-senders-guide.pdf` - Founder handbook
- `studio3-echoes-guide.pdf` - Supporter strategies
- `studio3-anchors-guide.pdf` - Validator framework
- `studio3-quickstart-guide.pdf` - Getting started guide

## 🚀 Deployment

### Automatic Deployment

The documentation automatically deploys to GitHub Pages when changes are pushed to the `main` branch through GitHub Actions.

### Manual Deployment

To manually deploy:
```bash
mkdocs gh-deploy
```

### Vercel

This site is published solely through GitHub Pages. The Vercel Git integration is switched off in `vercel.json` so it no longer attempts (and fails) a deployment on every commit and pull request.

## 🤝 Contributing

We welcome contributions to improve the documentation! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Make your changes
4. Commit with clear messages (`git commit -m 'Add new section on X'`)
5. Push to your fork (`git push origin feature/improvement`)
6. Open a Pull Request

### Documentation Style Guide

- Use clear, concise language
- Include practical examples
- Follow the existing formatting patterns
- Test all links and references
- Ensure responsive design works

## 📝 License

© 2025 by <a href="https://creativecommons.org">At Bryde Ud Ltd.</a>All rights reserved. Studio 3 is licensed under <a href="https://creativecommons.org/licenses/by-nd/4.0/">CC BY-ND 4.0</a> <img src="https://mirrors.creativecommons.org/presskit/icons/cc.svg" alt="" style="max-width: 1em;max-height:1em;margin-left: .2em;"><img src="https://mirrors.creativecommons.org/presskit/icons/by.svg" alt="" style="max-width: 1em;max-height:1em;margin-left: .2em;"><img src="https://mirrors.creativecommons.org/presskit/icons/nd.svg" alt="" style="max-width: 1em;max-height:1em;margin-left: .2em;">

This means you are free to:
- **Share** — copy and redistribute the material in any medium or format for any purpose, even commercially

Under the following terms:
- **Attribution** — You must give appropriate credit to "Studio 3 © 2025 by Studio 3 Canada", provide a link to the license, and indicate if changes were made
- **NoDerivatives** — If you remix, transform, or build upon the material, you may not distribute the modified material

See [LICENSE](LICENSE) for the full license text.

## 🏗️ Project Structure

```
studio3-docs/
├── docs/                    # Documentation source files
│   ├── index.md            # Homepage
│   ├── overview-guide/     # Overview documentation
│   ├── senders-guide/      # Founders documentation
│   ├── echoes-guide/       # Supporters documentation
│   ├── anchors-guide/      # Validators documentation
│   ├── assets/             # Images and downloadable files
│   ├── pdf/                # Generated PDF files
│   └── stylesheets/        # Custom CSS
├── mkdocs.yml              # MkDocs configuration
├── requirements.txt        # Python dependencies
├── generate_docs.py        # Documentation generator script
└── README.md              # This file
```

## 🌟 Key Features

- **Comprehensive Coverage**: 50+ pages of detailed documentation
- **Role-Based Guides**: Tailored content for each participant type
- **Interactive Elements**: Arena cards, phase indicators, and visual aids
- **Professional PDFs**: High-quality PDF exports for offline reading
- **Responsive Design**: Optimized for all devices
- **Dark Mode Support**: Easy on the eyes for extended reading
- **Search Functionality**: Quickly find what you need
- **Version Control**: Full history of documentation changes

## 📞 Contact

For questions about the documentation:
- Open an issue on [GitHub](https://github.com/inocult/studio3-docs/issues)
- Contact the Studio3 team through official channels

## 🙏 Acknowledgments

- Studio3 team for the platform vision
- MkDocs and Material theme contributors
- Community members who provided feedback
- All contributors to this documentation
- Built with [MkDocs](https://www.mkdocs.org/)
- Styled with [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- Deployed with [GitHub Pages](https://pages.github.com/)

---

**Studio3** - Where Belief Becomes Momentum 🚀