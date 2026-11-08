# Fedora Laptop Setup

Documentation for Fedora setup specific to my laptop.

## System Info

- Laptop: Asus Tuf A14 (2025)
- Processor: AMD Ryzen AI 7 350
- Graphics: NVIDIA GeForce RTX 5060 Laptop

## Applications

- Easy Effects (Software)
- NVIDIA Linux Graphics Driver (Software)
- Wayland Scroll Factor (Copr: `daniel-g-carrasco/wayland-scroll-factor`)

## Setup

### Improve speaker quality

The speakers on this laptop are poorly tuned. Easy Effects makes it really
straightforward to tune the speakers. I found a preset called "Advanced Auto
Gain" that someone made to help with laptop speaker sound that significantly
improves output quality:

https://github.com/JackHack96/EasyEffects-Presets/blob/master/Advanced%20Auto%20Gain.json

### Adjust scroll sensitivity

Scrolling with the trackpad is too sensitive on this laptop. Setting vertical
and horizontal scroll to `0.25` in Wayland Scroll Factor feels better.

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
state with decreased acceleration and click sensitivity. It seems like this is a
hardware issue caused by electrical interference, and I might make a warranty
claim for it.
