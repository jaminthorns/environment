# Fedora Laptop Setup

- Operating System: Fedora 44
- Laptop: [Asus Tuf A14 (2025)](https://www.asus.com/laptops/for-gaming/tuf-gaming/asus-tuf-gaming-a14-2025/)
- Processor: AMD Ryzen AI 7 350
- Graphics: NVIDIA GeForce 5060 Laptop

## To-Do

- Sync startup applications
- Sync Gnome keyboard shortcuts
- Sync enabled services
- Finish keymapper config
- Disable adaptive backlight management

## Applications

- Steam (Software)
- Flatseal (Software)
- KeePassXC (Software)
- Obsidian (Software)
- Tweaks (Software)
- NVIDIA Linux Graphics Driver (Software)
- Easy Effects (Software)
- Visual Studio Code (Website)
- Wezterm (Website)
- Ghostty (Website)
- Vivaldi (Website)
- Wayland Scroll Factor (Website)

## GNOME Extensions

- [AATWS (Advanced Alt-Tab Window Switcher)](https://extensions.gnome.org/extension/4412/advanced-alttab-window-switcher/)
- [Auto Power Profile](https://extensions.gnome.org/extension/6583/auto-power-profile/)
- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
- [Medialine](https://extensions.gnome.org/extension/10076/medialine/)
- [Transparent Top Bar (Adjustable transparency)](https://extensions.gnome.org/extension/3960/transparent-top-bar-adjustable-transparency/)
- [Run or Raise](https://extensions.gnome.org/extension/1336/run-or-raise/)
- [Keymapper](https://github.com/houmain/keymapper/tree/main/extra/share/gnome-shell/extensions/keymapper%40houmain.github.com)
- [No overview at start-up](https://extensions.gnome.org/extension/4099/no-overview/)
- [Caffeine](https://extensions.gnome.org/extension/517/caffeine/)
- [Hide minimized](https://extensions.gnome.org/extension/2639/hide-minimized/)

## NVIDIA Driver Installation

- Instructions: https://rpmfusion.org/Howto/NVIDIA

- Package installation (from Claude, would like to understand better):

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

## Screen Artifacts Fix

- Set `AMD_DEBUG=nodcc` in `/etc/environment`

## Face Authentication with LinuxCamPam

- Install LinuxCamPAM from COPR repo (https://copr.fedorainfracloud.org/coprs/funkemunky/linuxcampam/):

  ```sh
  sudo dnf copr enable funkemunky/linuxcampam
  sudo dnf install linuxcampam
  ```

- Enable LinuxCamPAM service:

  ```sh
  sudo systemctl enable linuxcampam.service --now
  ```

- Create new `authselect` profile:

  ```sh
  sudo authselect create-profile face --base-on local
  ```

- Add `pam_linuxcampam.so` line to `system-auth` and `password-auth` profiles under new profile (`/etc/authselect/custom/face`):

  ```
  auth        sufficient    pam_linuxcampam.so
  ```

- Select new `authselect` profile:

  ```sh
  sudo authselect select custom/face
  ```

- Attempt a login from lockscreen (should fail because GDM doesn't have access to camera).

- Generate an SELinux module from failure:

  ```sh
  sudo ausearch -m avc -ts recent | audit2allow -M linuxcampam_xdm
  sudo semodule -i linuxcampam_xdm.pp
  ```

## Better Speaker Quality

The [Advanced Auto Gain](https://github.com/JackHack96/EasyEffects-Presets/blob/master/Advanced%20Auto%20Gain.json) preset sounds pretty good.
