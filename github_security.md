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

```bash
brew install gnupg
gpg --card-edit
```

```bash
admin
passwd

```