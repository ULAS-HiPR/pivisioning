{ config, lib, pkgs, ... }: {
  services = {
    openssh = {
      enable = true;
    };
    
    timesyncd.enable = true;
  };
}
