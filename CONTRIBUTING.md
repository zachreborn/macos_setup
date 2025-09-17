# Contributing to macOS Setup

Thank you for your interest in contributing to this macOS setup automation project! 🎉

## 🚀 Quick Start

1. **Fork the repository** and clone your fork
2. **Create a new branch** for your feature: `git checkout -b feature/my-new-feature`
3. **Test your changes** with the dry-run mode: `./scripts/bootstrap-macos.sh --dry-run`
4. **Submit a pull request** using our PR template

## 📋 Types of Contributions

### 🔧 Adding New Tools
When adding a new development tool:

1. **Add to the script** in the appropriate array (`FORMULAE` or `CASKS`)
2. **Update the README.md** in both automated and manual sections
3. **Add verification** to the script's verification section
4. **Test installation** with both dry-run and actual installation
5. **Include usage examples** in the manual installation section

### 🐛 Bug Fixes
- Use the bug report issue template
- Include reproduction steps and environment details
- Test your fix on both Apple Silicon and Intel if possible

### 📚 Documentation Updates
- Keep README.md and script documentation in sync
- Use clear, concise language
- Include examples where helpful

## 🧪 Testing Your Changes

### Required Tests
```bash
# 1. Lint your shell scripts
shellcheck scripts/bootstrap-macos.sh

# 2. Test dry-run mode
./scripts/bootstrap-macos.sh --dry-run

# 3. Test actual installation (optional but recommended)
./scripts/bootstrap-macos.sh
```

### CI/CD Pipeline
Our GitHub Actions will automatically:
- ✅ Lint shell scripts with shellcheck
- ✅ Validate JSON/YAML configuration files  
- ✅ Test dry-run mode functionality
- ✅ Check for security issues
- ✅ Validate documentation consistency

## 📝 Code Style Guidelines

### Shell Scripts
- Use `#!/usr/bin/env bash` shebang
- Enable strict mode: `set -euo pipefail`
- Use meaningful variable names
- Add comments for complex logic
- Follow existing patterns for consistency

### Documentation
- Use clear, concise language
- Include code examples where helpful
- Keep line lengths reasonable (< 120 chars)
- Use consistent markdown formatting

## 🔒 Security Considerations

- **Never commit secrets** or personal information
- **Avoid dangerous commands** like `rm -rf /`
- **Validate user input** where applicable  
- **Use official installation methods** (homebrew, official installers)
- **Test on clean systems** when possible

## 📦 Pull Request Process

1. **Use our PR template** - it will be automatically populated
2. **Fill out all sections** in the template
3. **Link related issues** if applicable
4. **Test thoroughly** before submitting
5. **Respond to feedback** promptly

### PR Checklist
- [ ] Code follows project style guidelines
- [ ] Self-reviewed the changes
- [ ] Added/updated documentation
- [ ] Tested with `--dry-run` mode
- [ ] All CI checks pass
- [ ] Added to both script and README (for new tools)

## 🏗️ Development Setup

### Prerequisites
- macOS 11+ (Big Sur or later)
- Git
- Terminal application (Terminal, iTerm2, Warp)

### Repository Structure
```
.
├── .github/                # GitHub Actions, templates, configs
├── .config/fish/          # Fish shell configuration
├── .poshthemes/           # Oh-My-Posh themes
├── .warp/themes/          # Warp terminal themes
├── scripts/               # Bootstrap and utility scripts
├── README.md              # Main documentation
└── CONTRIBUTING.md        # This file
```

### Local Development
```bash
# Clone your fork
git clone https://github.com/YOUR-USERNAME/macos_setup.git
cd macos_setup

# Create feature branch
git checkout -b feature/my-feature

# Make changes and test
./scripts/bootstrap-macos.sh --dry-run

# Commit and push
git add .
git commit -m "feat: add new awesome tool"
git push origin feature/my-feature
```

## 🤝 Community Guidelines

- **Be respectful** and inclusive
- **Help others** learn and contribute
- **Ask questions** if you're unsure
- **Share knowledge** about macOS development setup
- **Keep discussions focused** on the project

## 📞 Getting Help

- **Create an issue** for bugs or feature requests
- **Check existing issues** before creating new ones
- **Use appropriate labels** to categorize issues
- **Provide context** and reproduction steps

## 🎯 Project Goals

This project aims to:
- **Simplify macOS development setup** for new developers
- **Automate repetitive installation tasks** 
- **Provide consistent environments** across team members
- **Stay current** with modern development tools
- **Support both Apple Silicon and Intel** Macs

## 📄 License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

**Happy Contributing!** 🚀

Your contributions help make macOS development setup easier for everyone!