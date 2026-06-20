# Fedora Laptop Setup

I'm running Fedora on an Asus Tuf A14 with an RTX 4060 paired with integrated graphics.

## Applications

- Steam (Software)
- Flatseal (Software)
- KeePassXC (Software)
- Tweaks (Software)
- NVIDIA Linux Graphics Driver (Software)
- Visual Studio Code (Website)
- Wezterm (Website)
- Vivaldi (Website)
- Wayland Scroll Factor (Website)

## GNOME Extensions

- AATWS
- Auto Power Profile
- Dash to Dock
- Medialine

## NVIDIA Driver Installation

- Instructions: https://rpmfusion.org/Howto/NVIDIA

- Package installation (from Claude, would like to understand better):

  ```
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

## Screen Artifacts

- Set `AMD_DEBUG=nodcc` in `/etc/environment`
