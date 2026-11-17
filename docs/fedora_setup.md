# Fedora Setup

Documentation for general Fedora setup.

## Fedora Applications

## Environment

- Gaze (Installation: https://gaze.gundulabs.com/guide/installation.html)
- Ghostty (Copr: `scottames/ghostty`)
- Keymapper (Installation: https://github.com/houmain/keymapper#installation)
- Visual Studio Code (Installation:
  https://code.visualstudio.com/docs/setup/linux)

## General

- Convey (Software)
- Discord (Software)
- KeePassXC (Software)
- Obsidian (Software)
- Spotify (Software)
- Todoist (Software)
- Vivaldi (Installation: https://vivaldi.com/download/)

### Gaming

- BedrockOnLinux (Installation: https://wyze3306.github.io/BedrockOnLinux/#get)
- Solaar (Software)
- Steam (Software)

## Setup

### Set up Google Drive with rclone

Create a Google Drive remote:

```sh
rclone config create google_drive drive --all
```

Do an initial sync of the passwords folder:

```sh
rclone bisync google_drive:Passwords ~/Passwords/ --resync
```

The systemd services in this repository will take care of the rest.

### Disable disk encryption password

When the disk is encrypted, a password is required on every boot. This password
can be stored on the
[TPM](https://en.wikipedia.org/wiki/Trusted_Platform_Module) so that it doesn't
need to be entered. This has some security downsides, but I think it's worth the
convenience.

Find the encrypted partition:

```sh
lsblk
```

Enroll the TPM device:

```sh
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/ENCRYPTED_PARTITION
```
