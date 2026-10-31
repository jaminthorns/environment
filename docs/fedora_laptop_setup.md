# Fedora Laptop Setup

## System Specifications

- Operating System: Fedora 44
- Laptop: [Asus Tuf A14 (2025)](https://www.asus.com/laptops/for-gaming/tuf-gaming/asus-tuf-gaming-a14-2025/)
- Processor: AMD Ryzen AI 7 350
- Graphics: NVIDIA GeForce 5060 Laptop

## To-Do

- Sync Copr repos and packages
- Sync NVIDIA packages
- Store Easy Effects preset
- Sync function key lock config
- Sync ZRAM config
- Create script for storing disk encryption passphrase in TPM

## Issues

- Touchpad sometimes degrades to a condition with worse acceleration/click behavior
  - Lasts 30-60 sec before it restores automatically
  - Immediate fix: reboot the drivers

    ```sh
    sudo rmmod i2c_hid_acpi && sudo modprobe i2c_hid_acpi
    ```

## NVIDIA Driver Installation

Instructions: https://rpmfusion.org/Howto/NVIDIA

Package installation (from Claude, would like to understand better):

```sh
sudo dnf install \
  akmod-nvidia \
  xorg-x11-drv-nvidia \
  xorg-x11-drv-nvidia-cuda \
  xorg-x11-drv-nvidia-libs \
  xorg-x11-drv-nvidia-libs.i686 \
  xorg-x11-drv-nvidia-power \
  libva-nvidia-driver.{i686,x86_64} \
  vulkan-loader vulkan-loader.i686
```

But I probably only need `xorg-x11-drv-nvidia-libs.i686` (test this)

## Better Speaker Quality

The [Advanced Auto Gain](https://github.com/JackHack96/EasyEffects-Presets/blob/master/Advanced%20Auto%20Gain.json) preset sounds pretty good.

## Enroll disk encryption passphrase in TPM device

Find encrypted partition:

```sh
lsblk
```

Enroll the TPM device:

```sh
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/YOUR_PARTITION
```

## Disable function key kock by default

Create `/etc/modprobe.d/asus_wmi.conf`:

```
options asus_wmi fnlock_default=N
```

## Increase ZRAM size to full memory

Create `/etc/systemd/zram-generator.conf`:

```
[zram0]
zram-size=ram
compression-algorithm=zstd
```
