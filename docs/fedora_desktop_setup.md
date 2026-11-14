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

### Fix mouse horizontal scroll direction

The default horizontal scroll direction for my Logitech MX Master mouse is
inverted. It can easily be fixed with a device quirk.

Install `libinput-utils`:

```sh
sudo dnf install libinput-utils
```

Create `/etc/libinput/local-overrides.quirks`:

```
[Logitech MX Master]
MatchName=Logitech USB Receiver Mouse
ModelInvertHorizontalScrolling=1
```

### Disable Intel HD Audio controller

The onboard audio for my motherboard seems to be misbehaving, which through
several crazy steps causes delays of several seconds every time the display
sleeps or wakes. This is what's happening:

- Intel audio shares an interrupt line with NVIDIA audio
- Intel audio causes an interrupt storm which disables interrupt line
- NVIDIA graphics needs to update audio state for every sleep/wake
- Audio state update has to wait for timeout since interrupt line is disabled

The Intel audio can just be disabled since I use USB audio.

Create `/etc/udev/rules.d/80-disable-intel-hda.rules`:

```
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{class}=="0x040300", ATTR{remove}="1"
```
