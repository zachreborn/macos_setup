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
- Github Desktop
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


# Initial Set Up
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