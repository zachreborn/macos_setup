# macos_setup
This respository is for setting up a new Macbook with various settings I've grown to like.

# List of applications
- Brew
- Google Chrome
- Magnet
- fish
- Oh-My-Posh
- Hyper
- warp
- Homebrew
- VS Code
    - Alignment
    - Docker
    - Git Graph
    - GitLense
    - GitHub Pull Request and Issues
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
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install fish awscli hyper python terraform pyenv pipenv ykman
```
# Installations
## Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Google Chrome
```bash
brew install --cask google-chrome
```

## Github Desktop
```bash
brew install --cask github
```

## Amazon Workspaces
```bash
brew install --cask amazon-workspaces
```

## VS Code
```bash
brew install --cask visual-studio-code
```

## Magnet
https://apps.apple.com/us/app/magnet/id441258766?mt=12
## fish
https://fishshell.com/
```bash
brew install fish
sudo bash -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
chsh -s /opt/homebrew/bin/fish
```

## Oh-My-Posh
```bash
brew tap jandedobbeleer/oh-my-posh
brew install oh-my-posh
oh-my-posh init fish --config ~/.poshthemes/octo.theme.json | source
```

## AWS CLI
```bash
brew install awscli
```

## Nerd Fonts
https://www.nerdfonts.com/font-downloads
```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

## Hyper
https://hyper.is/
```bash
brew install hyper
hyper install hyper-material-theme
```

## Warp
https://www.warp.dev/
```bash
brew install --cask warp
mkdir ~/.warp/themes
cd ~/.warp/themes
curl -O "https://raw.githubusercontent.com/zachreborn/warp_theme_hyper_material/main/hyper_material.yaml"
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

## htop
```bash
brew install htop
```

## Discord
```bash
brew install --cask discord
```

## Steam
```bash
brew install --cask steam
```
