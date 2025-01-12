{ config, lib, pkgs, ... }: {
  networking = {
    hostName = "mach25";

    useDHCP = false;
    interfaces = {
      eth0.useDHCP = true;
      wlan0.useDHCP = true;
    };
    
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
      networks = {
        "coldspot" = {
          psk = "helloworld1";
        };
      };
    };
    
    firewall.allowedTCPPorts = [ 22 ];
  };
}
