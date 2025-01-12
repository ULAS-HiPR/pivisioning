{ config, lib, pkgs, ... }: {
  imports = [
    ./sd-image-init.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/services.nix
    ./modules/tools.nix
  ];

 boot.loader.grub.enable = false; # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.generic-extlinux-compatible.enable = true; # Enables the generation of /boot/extlinux/extlinux.conf
 
  boot.kernelModules = [ "i2c-dev" "i2c-bcm2708" "gpio" ];
  system.stateVersion = "24.05";
}
