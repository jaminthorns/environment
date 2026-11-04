# Fedora Laptop Setup

## System Info

- Laptop: Asus Tuf A14 (2025)
- Processor: AMD Ryzen AI 7 350
- Graphics: NVIDIA GeForce 5060 Laptop

## Applications

- Easy Effects (Software)
- Gaze (Installation: https://gaze.gundulabs.com/guide/installation.html)
- NVIDIA Linux Graphics Driver (Software)
- Wayland Scroll Factor (Copr: `daniel-g-carrasco/wayland-scroll-factor`)

## Tweaks

### Improve speaker quality

The speakers on this laptop are poorly tuned. Easy Effects makes it really
straightforward to tune the speakers. I found a preset called "Advanced Auto
Gain" that someone made to help with laptop speaker sound that significantly
improves output quality:

https://github.com/JackHack96/EasyEffects-Presets/blob/master/Advanced%20Auto%20Gain.json

### Adjust scroll sensitivity

Scrolling with the trackpad is too sensitive on this laptop. Setting vertical
and horizontal scroll to `0.25` in Wayland Scroll Factor feels better.

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

### Default to system hotkeys

I prefer the top row of keys to have their system functions (volume, keyboard
brightness, display brightness, etc.) by default instead of F1-F12.

Create `/etc/modprobe.d/asus_wmi.conf`:

```
options asus_wmi fnlock_default=N
```

### Fix washed out display on power saving mode

This is due to [AMD Adaptive Backlight
Modulation](https://docs.kernel.org/gpu/amdgpu/display/display-contributing.html#adaptive-backlight-modulation-abm),
which causes the display on this laptop to look washed out.

Add a kernel parameter to disable it:

```
sudo grubby --update-kernel=ALL --args="amdgpu.abmlevel=0"
```

### Increase ZRAM size

This laptop only has 16GB of RAM and can run out under heavy load. Increasing
the [ZRAM](https://en.wikipedia.org/wiki/Zram) to the full RAM size and changing
to more memory-efficient compression can help with this.

Create `/etc/systemd/zram-generator.conf`:

```
[zram0]
zram-size=ram
compression-algorithm=zstd
```

## Issues

### Touchpad ghost touches and degraded state

The touchpad occasionally experiences ghost touches and falls back to a degraded
state with decreased acceleration and click sensitivity. It seems like CPU power
saving (C-State 3) might be causing electrical issues that in turn causes this.
This is observable as coil whine when listening closely near the touchpad. This
can be tested by observing that sustained CPU load makes coil whine go away:

```
yes > /dev/null
```

If the touchpad falls into a degraded state, you can restart the touchpad kernel
module:

```
sudo modprobe -r i2c_hid_acpi && sudo modprobe i2c_hid_acpi
```

As a temporary workaround, I've disabled the lowest CPU idle state while the
laptop is awake with these systemd services:

- `disable-c3-boot.service`

  ```
  [Unit]
  Description=Disable CPU C3 idle state on boot (touchpad issue workaround)

  [Service]
  Type=oneshot
  ExecStart=/usr/bin/cpupower -c all idle-set -d 3

  [Install]
  WantedBy=multi-user.target
  ```

- `disable-c3-sleep.service`

  ```
  [Unit]
  Description=Handle CPU C3 idle state around suspend (touchpad issue workaround)
  Before=sleep.target
  StopWhenUnneeded=yes

  [Service]
  Type=oneshot
  RemainAfterExit=yes
  ExecStart=/usr/bin/cpupower -c all idle-set -e 3
  ExecStop=/usr/bin/cpupower -c all idle-set -d 3

  [Install]
  WantedBy=sleep.target
  ```

I might make a warranty claim for this, since it seems to be a hardware issue.
