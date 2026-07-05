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
- Transparent Top Bar (Adjustable Transparency)

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
