{ config, pkgs, ... }:

{
  networking.hostName = "zeroprime-cc";

  # Raspberry Pi Bootloader
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # User definition
  users.users.bob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };

  # SSH Service
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  # Syncthing setup for Pi
  services.syncthing = {
    enable = true;
    user = "bob";
    openDefaultPorts = true;
    dataDir = "/home/bob";
    configDir = "/home/bob/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "vivobook-s" = {
          id = "77OLQKP-HSJUUYE-GXPLZA5-P4C2VR4-H23XWCX-HJ2FUGJ-UTHBJNC-IWPDEAI";
        };
      };
      folders = {
        "prima-materia" = {
          path = "/home/bob/prima-materia";
          devices = [ "vivobook-s" ];
        };
      };
    };
  };

  system.stateVersion = "25.11";
}
