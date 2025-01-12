{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Common utils
    wget
    curl
    usbutils
    htop 
    
    # GPIO and I2C tools
    wiringpi
    i2c-tools
    python3Packages.rpi-gpio
    python3Packages.smbus2
    
    # Database
    sqlite
    sqlite-interactive  # 
   
    # Development 
    go
    vim 
    git          
    python3
    python3Packages.pip
    gnumake
    
    # Hardware inspection
    lshw
    pciutils
  ];

  # Environment variables
  environment.variables = {
    PYTHONPATH = "${pkgs.python3}/bin/python3";
    GOPATH = "$HOME/go";
    GOBIN = "$GOPATH/bin";
    EDITOR = "vim";
  };


  nixpkgs.config.allowUnfree = true;
}
