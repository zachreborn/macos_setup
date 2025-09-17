# GitHub Security Set Up
The following is a guide to setting up security on a new device with GitHub

# SSH and Yubikey


```bash
ssh-keygen -a 100 -t ed25519-sk -b 521 -C your_name@example.org -O resident
```
## Command flag information:

-a
-b
-t
-C
-O 

# GPG
Yubikey guide and walkthrough: https://developers.yubico.com/PGP/PGP_Walk-Through.html

This configuration guide sets up GPG to be utilized with a Yubikey and Github.

## Installation
The following tools are utilized
- gnupg
-- gnupg is leveraged to generate the keys and manage signing
- pinentry-mac
-- pinentry-mac is leveraged to open a pin entry window when git signs a commit

```bash
brew install gnupg pinentry-mac
```

## GPG Set Up and Key Generation
```bash
gpg --card-edit
admin
passwd
generate
```


## Troubleshooting code signing failure
https://gist.github.com/Peredery/38d0538dd34381bbd9d13414269a1f27

## Additional information
https://github.com/YubicoLabs/sign-git-commits-yubikey
https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key