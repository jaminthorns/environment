# Fedora Desktop Setup

Documentation for Fedora setup specific to my desktop.

## System Info

- Processor: Intel Core i9-13900K
- Graphics: NVIDIA GeForce RTX 3070
- Motherboard: MSI MPG Z790I EDGE WIFI

## Applications

- LACT (Software)
- NVIDIA Linux Graphics Driver (Software)

## Setup

### Allow NVIDIA drivers during boot

By default, the NVIDIA drivers are omitted from being compiled into the initial
RAM filesystem (initramfs), which causes the splash screen and disk encryption
password prompt to not be shown when booting from an NVIDIA GPU. If disk
encryption is enabled without storing the password in TPM, this will prevent the
system from booting (remove `rhgb` kernel parameter at boot to get around this).

Create `/etc/dracut.conf.d/99-nvidia-dracut.conf`:

```
add_drivers+=" nvidia nvidia-drm nvidia-modeset nvidia-uvm "
```

On kernel updates, initramfs gets rebuilt before the NVIDIA kernel module gets
built. On NVIDIA driver updates, initramfs isn't automatically rebuilt. Either
way, this means the kernel module won't automatically be included in initramfs.

To fix this, always update these through `dnf upgrade` instead of Software:

```sh
sudo dnf upgrade --refresh "kernel*" "*nvidia*"
```

Wait for the kernel module to rebuild:

```sh
modinfo nvidia -F version
```

And rebuild initramfs:

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

### Disable Intel HD Audio controller

The onboard audio for my motherboard seems to be misbehaving, which through
several crazy steps causes delays of several seconds every time the display
sleeps or wakes. This is what's happening:

- Intel audio shares an interrupt line with NVIDIA audio
- Intel audio causes an interrupt storm which disables interrupt line
- NVIDIA graphics needs to update audio state for every sleep/wake
- Audio state update has to wait for timeout since interrupt line is disabled

When this happens it can be detected from the kernel logs:

```sh
sudo dmesg | grep -i "disabling irq"
```

To fix the issue, the Intel audio can just be disabled since I use USB audio.

Create `/etc/udev/rules.d/80-disable-intel-hda.rules`:

```
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{class}=="0x040300", ATTR{remove}="1"
```

### Disable SteelSeries Arctis driver

The SteelSeries Arctis driver is incorrectly powering off the receiver for my
SteelSeries Arctis 7 Pro headphones. It can be disabled in favor of the generic
driver.

Create `/etc/modprobe.d/steelseries-arctis-blacklist.conf`:

```
blacklist hid_steelseries_arctis
```

This driver is also present in initramfs, so rebuild it:

```sh
sudo dracut --force
```

### Undervolt the GPU

The GPU can be undervolted to lower the thermals and bring it below the
throttling limit (the airflow on my desktop's compact case is not great). This
is the result of trial and error to find a point of stability near the max clock
rate of ~1900 MHz:

- In LACT enable VF curve editing and open the VF curve editor
- Select the entire curve and drag the 850 mV point up to 1900 Mhz
- Flatten the curve to the right of 850 mV
