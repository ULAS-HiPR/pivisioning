{ config, lib, pkgs, ... }: {
  users.users.dev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "gpio" "i2c" ];
    createHome = true;
    home = "/home/dev";
    shell = pkgs.bashInteractive;
    password = "dev";
  };

  system.activationScripts = {
    setupGoWorkspace = {
      deps = [];
      text = ''
        mkdir -p /home/dev/go/{bin,pkg,src}
        chown -R dev:users /home/dev/go
      '';
    };
  };
}
