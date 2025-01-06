{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
    ./sd-image-init.nix
  ];

  # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low
  # on space.
  sdImage.compressImage = false;

  sdImage.populateRootCommands = ''
    mkdir -p ./files/etc/sd-image-metadata/
    cp /configuration.nix ./files/etc/sd-image-metadata/configuration.nix
    cp /sd-image-init.nix ./files/etc/sd-image-metadata/sd-image-init.nix
  '';

  # OpenSSH is forced to have an empty `wantedBy` on the installer system[1], this won't allow it
  # to be automatically started. Override it with the normal value.
  # [1] https://github.com/NixOS/nixpkgs/blob/9e5aa25/nixos/modules/profiles/installation-device.nix#L76
  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  # Enable OpenSSH out of the box.
  services.sshd.enable = true;

  # allow dev to ssh remotely at login

  # create a dev usr that is not root but has ssh and exec access
  users.users.dev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    createHome = true;
    home = "/home/dev";
    shell = pkgs.bashInteractive;
    password = "dev";
  };

  # Wireless networking (1). You might want to enable this if your Pi is not attached via Ethernet.
  networking.wireless = {
   enable = true;
   interfaces = [ "wlan0" ];
   networks = {
     "coldspot" = {
       psk = "helloworld1";
     };
   };
  };

  # Wireless networking (2). Enables `wpa_supplicant` on boot.
  systemd.services.wpa_supplicant.wantedBy = lib.mkOverride 10 [ "default.target" ];

  system.stateVersion = "24.05"; 
  services.timesyncd.enable = true; # NOTE: Sync time with NTP servers.
  networking.firewall.allowedTCPPorts = [ 22 ];
}
