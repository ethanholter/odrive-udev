<div align="center">
  <img src="https://images.squarespace-cdn.com/content/v1/58aff26de4fcb53b5efd2f02/3ec646bb-3aae-4924-a7c0-6de9f31c6069/Pro_shadow.png" alt="ODrive Pro" width="400"/>

  <h1>ODrive udev Flake</h1>

  <p>A Nix flake that packages the official <a href="https://odriverobotics.com">ODrive</a> udev rules,<br>making it easy to use ODrive motor controllers on NixOS.</p>

  <p>
    <a href="https://odriverobotics.com"><img src="https://img.shields.io/badge/Website-odriverobotics.com-blue?style=for-the-badge&logo=googlechrome&logoColor=white" alt="Website"/></a>
    <a href="https://docs.odriverobotics.com"><img src="https://img.shields.io/badge/Docs-docs.odriverobotics.com-blue?style=for-the-badge&logo=readthedocs&logoColor=white" alt="Documentation"/></a>
    <a href="https://gui.odriverobotics.com"><img src="https://img.shields.io/badge/Web_GUI-gui.odriverobotics.com-orange?style=for-the-badge&logo=windowsterminal&logoColor=white" alt="Web GUI"/></a>
    <a href="https://github.com/odriverobotics/ODrive"><img src="https://img.shields.io/badge/GitHub-ODrive-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/></a>
  </p>
</div>

---

## What this does

Installs `91-odrive.rules` from [ODrive Robotics](https://odriverobotics.com) into `/lib/udev/rules.d/`, required for the [ODrive Web GUI](https://gui.odriverobotics.com) to communicate with the devices. See the [Web GUI documentation](https://docs.odriverobotics.com/v/latest/interfaces/gui.html) for more details.

## Usage

### NixOS module (recommended)

Add to your `flake.nix` inputs:

```nix
odrive-udev.url = "github:ethanholter/odrive-udev";
```

Then enable the module in your NixOS configuration:

```nix
{ inputs, ... }: {
  imports = [ inputs.odrive-udev.nixosModules.default ];
}
```

### Install as a package

```bash
nix profile install github:ethanholter/odrive-udev
```

Or in a NixOS `environment.systemPackages`:

```nix
environment.systemPackages = [
  inputs.odrive-udev.packages.${pkgs.stdenv.hostPlatform.system}.default
];
```

## Supported devices

| Device | |
|--------|-|
| [ODrive Pro](https://shop.odriverobotics.com/products/odrive-pro) | ✓ |
| [ODrive S1](https://shop.odriverobotics.com/products/odrive-s1) | ✓ |
| [ODrive Micro](https://shop.odriverobotics.com/products/odrive-micro) | ✓ |
| [USB-CAN Adapter](https://shop.odriverobotics.com/products/usb-can-adapter) | ✓ |

## Source

The udev rules file is fetched directly from [`cdn.odriverobotics.com`](https://cdn.odriverobotics.com/files/odrive-udev-rules.rules). For more on Linux USB setup with ODrive, see the [ODrive documentation](https://docs.odriverobotics.com/v/latest/getting-started.html).
