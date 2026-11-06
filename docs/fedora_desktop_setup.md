# Fedora Desktop Setup

Documentation for Fedora setup specific to my desktop.

## System Info

- Processor: Intel Core i9-13900K
- Graphics: NVIDIA GeForce RTX 3070

## Applications

- NVIDIA Linux Graphics Driver (Software)

## Setup

### Allow NVIDIA drivers during boot

By default, the NVIDIA drivers are omitted from being compiled into the initial
RAM filesystem (initramfs), which causes the splash screen and disk encryption
password entry to not be shown when booting from an NVIDIA GPU.


Create `/etc/dracut.conf.d/99-nvidia-dracut.conf`:

```
add_drivers+=" nvidia nvidia-drm nvidia-modeset nvidia-uvm "
```

Rebuild initramfs:

```sh
sudo dracut --force
```

### Grant raw access to QMK keyboard

Web apps that interface with QMK keyboards won't work because they don't have
raw HID access to the device. I need this for configuring my Keychron keyboard.

Find the keyboard device:

```sh
lsusb | grep -i keychron
```

Create `/etc/udev/rules.d/59-keyboard-raw-hid-access.rules`:

```
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0121", MODE="0660", TAG+="uaccess"
```

Reload udev and devices:

```sh
sudo udevadm control --reload-rules && sudo udevadm trigger
```
