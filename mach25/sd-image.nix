{ config, lib, pkgs, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
    ./configuration.nix
  ];

  sdImage = {
    compressImage = true;
    populateRootCommands = ''
      mkdir -p ./files/etc/sd-image-metadata/
      cp /configuration.nix ./files/etc/sd-image-metadata/configuration.nix
      cp /sd-image-init.nix ./files/etc/sd-image-metadata/sd-image-init.nix
      cp -r /modules ./files/etc/sd-image-metadata/
    '';
  };

  system.stateVersion = "24.05";
}
