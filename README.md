# macos_setup

This respository is for setting up a new Macbook with various settings I've grown to like.

# List of applications

- Brew
- Google Chrome
- Magnet
- fish
- Oh-My-Posh
- warp
- Homebrew
- VS Code
  - Alignment
  - Docker
  - Git Graph
  - GitLense
  - GitHub Pull Request and Issues
  - GitHub Copilot
  - HashiCorp Terraform
- GitHub Desktop
- GitHub CLI
- AWS CLI
- pyenv
- pipenv
- python
- terraform
- terraform-docs
- Dropbox
- Magnet
- Nerd Fonts
- ykman
- gpg
- pinentry-mac
- obsidian
- docker
- glances
- Discord
- Soundsource
- fd
- ripgrep

# Automated Installation

**The easiest way to set up your macOS environment is with the automated bootstrap script:**

```bash
# Clone this repository and run the bootstrap script
git clone https://github.com/zachreborn/macos_setup.git
cd macos_setup
./scripts/bootstrap-macos.sh
```

**Features of the bootstrap script:**
- ✅ **Idempotent** - Safe to run multiple times
- ✅ **Comprehensive** - Installs everything listed below automatically
- ✅ **Smart** - Detects and handles Apple Silicon vs Intel Macs
- ✅ **Safe** - Includes dry-run mode and robust error handling
- ✅ **Configures** - Sets up shell, themes, and environment variables

**Options:**
```bash
# Preview what will be installed without making changes
./scripts/bootstrap-macos.sh --dry-run

# Normal installation
./scripts/bootstrap-macos.sh
```

**Prerequisites:**
- macOS 11+ (Big Sur or later)
- Admin access (sudo will be requested when needed)
- Internet connection

**What gets installed:**
- **Homebrew** package manager with auto-updates
- **CLI Tools:** fish, oh-my-posh, gh, aws, terraform, pyenv, pipenv, ykman, gpg, docker, fd, ripgrep, glances
- **GUI Apps:** Google Chrome, Warp, VS Code, GitHub Desktop, Discord, Dropbox, Steam, Obsidian, Docker Desktop, SoundSource, Amazon WorkSpaces  
- **Fonts:** Hack Nerd Font for terminal icons
- **Shell:** fish configured as default with Oh-My-Posh theme
- **Configurations:** GPG, pyenv, custom Warp theme, fish environment

---

# Manual Installation

If you prefer to install things manually or want to understand what the bootstrap script does, here are the individual steps:

## Initial Set Up

The installations of applications utilizes Homebrew as the package manager for MacOS. It is best practice to use a package manager for easier installation and keeping your applications up to date.

1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Configure automatic updates for Homebrew

```bash
brew autoupdate start --upgrade --cleanup --enable-notification
```

# Installations

## Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Google Chrome

1. Install Google Chrome

```bash
brew install --cask google-chrome
```

2. Login to Google Chrome

## Nerd Fonts

https://www.nerdfonts.com/font-downloads

```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

## Warp

https://www.warp.dev/

1. Install Warp

```bash
brew install --cask warp
mkdir -p ~/.warp/themes
cd ~/.warp/themes
curl -O "https://raw.githubusercontent.com/zachreborn/warp_theme_hyper_material/main/hyper_material.yaml"
cd ~
```

2. After installing, open Warp and go to Settings > Themes > Import Theme and select the hyper_material.yaml file.

## fish

https://fishshell.com/

1. Install fish and set it as the default shell

```bash
brew install fish
sudo bash -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
chsh -s /opt/homebrew/bin/fish
```

2. Set up fish to have brew in the path and update completions

```bash
fish_add_path /opt/homebrew/bin
fish_update_completions
```

3. Set up fish to run oh-my-posh and have all functions

```bash
cp -R ~/code/macos_setup/.config/fish/* ~/.config/fish/
```

## Oh-My-Posh

1. Install Oh-My-Posh

```bash
brew tap jandedobbeleer/oh-my-posh
brew install oh-my-posh
mkdir ~/.poshthemes
cd ~/.poshthemes
curl -O "https://raw.githubusercontent.com/zachreborn/macos_setup/main/.poshthemes/octo-theme.omp.json"
oh-my-posh init fish --config ~/.poshthemes/octo-theme.omp.json | source
cd ~
```

2. Reload your terminal
3. Verify that the theme is working by running `oh-my-posh --version`

## GitHub Desktop

1. Install GitHub Desktop

```bash
brew install --cask github
```

2. Run GitHub Desktop
3. Login to GitHub

## GitHub CLI

```bash
brew install gh
```

## Amazon Workspaces

```bash
brew install --cask amazon-workspaces
```

## VS Code

1. Install VS Code

```bash
brew install --cask visual-studio-code
```

2. Login to Github in VS Code to synchronize settings and plugins

## Magnet

1. Install Magnet by browsing to https://apps.apple.com/us/app/magnet/id441258766?mt=12
2. Open Magnet
3. Follow the setup instructions to enable Magnet to control your windows

## AWS CLI

```bash
brew install awscli
```

## Terraform

```bash
brew install terraform
```

## Terraform-docs

```bash
brew install terraform-docs
```

### Terraform-docs Usage

```bash
terraform-docs markdown table --output-file ./README.md .
```

## pyenv

https://hackernoon.com/reaching-python-development-nirvana-bb5692adf30c

```bash
brew install pyenv
```

## pipenv

https://hackernoon.com/reaching-python-development-nirvana-bb5692adf30c

```bash
brew install pipenv
```

## ykman

```bash
brew install ykman
```

## gpg

```bash
brew install gpg
```

## pinentry-mac

```bash
brew install pinentry-mac
```

## glances

```bash
brew install glances
```

## Discord

```bash
brew install --cask discord
```

## Dropbox

1. Install Dropbox

```bash
brew install --cask dropbox
```

2. Sign in to Dropbox
3. Configure synchronization settings

## Steam

```bash
brew install --cask steam
```

## Obsidian

```bash
brew install --cask obsidian
```

## Docker

```bash
brew install --cask docker-desktop
brew install docker
```

## Soundsource

```bash
brew install --cask soundsource
```

## fd
fd is a much better version of `find` for MacOS. It's more intuitive command structure is excellent and quite a bit faster at actually finding files.

```bash
brew install fd
```

## ripgrep
ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern. It's significantly faster than grep and has better default behavior for developers.

```bash
brew install ripgrep
```

### ripgrep Usage Examples

```bash
# Basic search
rg "search term"

# Search in specific file types
rg "function" --type js

# Case insensitive search
rg -i "TODO"

# Search with line numbers
rg -n "import"
```

---

# Older Configurations

## Hyper

https://hyper.is/

```bash
brew install hyper
hyper install hyper-material-theme
```

## htop

```bash
brew install htop
```
