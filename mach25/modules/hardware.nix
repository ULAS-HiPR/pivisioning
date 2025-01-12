{ config, lib, pkgs, ... }: {
  hardware.i2c.enable = true;

  
  users.groups = {
    gpio = {};
    i2c = {};
  };

}
