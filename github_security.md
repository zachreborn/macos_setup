# GitHub Security Set Up
The following is a guide to setting up security on a new device with GitHub

# SSH and Yubikey


```bash
ssh-keygen -a 100 -t ed25519-sk -b 521 -C zhill@thinkstack.co -O resident
```
## Command flag information:

-a
-b
-t
-C
-O 

# GPG
Yubikey guide and walkthrough: https://developers.yubico.com/PGP/PGP_Walk-Through.html

This configuration guide sets up GPG to be utilized with a Yubikey and Github. The guide performs the following:
1. Installs the necessary components

## Installation
The following tools are utilized
- gnupg
-- gnupg is leveraged to generate the keys and manage signing
- pinentry-mac
-- pinentry-mac is leveraged to open a pin entry window when git signs a commit

```bash
brew install gnupg pinentry-mac
```

```bash
gpg --card-edit
admin
passwd
generate
```