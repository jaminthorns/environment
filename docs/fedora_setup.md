# Fedora Setup

Documentation for general Fedora setup.

## Fedora Applications

- Convey
- Dconf Editor
- Discord
- Gaze (Installation: https://gaze.gundulabs.com/guide/installation.html)
- Ghostty (Copr: `scottames/ghostty`)
- KeePassXC
- Keymapper (Installation: https://github.com/houmain/keymapper#installation)
- Steam
- Todoist
- Visual Studio Code (Installation:
  https://code.visualstudio.com/docs/setup/linux)
- Vivaldi (Installation: https://vivaldi.com/download/)

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

### Disable disk encryption passphrase

When the disk is encrypted, a passphrase is required on every boot. This
passphrase can be stored on the
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
