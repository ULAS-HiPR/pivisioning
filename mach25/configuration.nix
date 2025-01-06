{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Needed to continue SD image initialization after installer removes its own unit.
    ./sd-image-init.nix
  ];

  
  boot.loader.grub.enable = false; # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.generic-extlinux-compatible.enable = true; # Enables the generation of /boot/extlinux/extlinux.conf
  services.sshd.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  services.timesyncd.enable = true; # NTP time sync.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
