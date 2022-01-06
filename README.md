# macos_setup
This respository is for setting up a new Macbook with various settings I've grown to like.

# List of applications
- fish
- Oh-My-Posh
- Hyper
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
- Dropbox
- Magnet
- Nerd Fonts

# Initial Set Up
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install fish awscli hyper python terraform
```
# Installations
## Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
## fish
```bash
brew install fish
```

## Oh-My-Posh
```bash
brew tap jandedobbeleer/oh-my-posh
brew install oh-my-posh
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
```bash
brew install hyper
```