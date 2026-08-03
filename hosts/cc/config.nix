{ config, pkgs, ... }:

{
  imports = [
    ../../modules/syncthing.nix
  ];
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
    user = "bob";
    dataDir = "/home/bob";
    configDir = "/home/bob/.config/syncthing";
  };

  system.stateVersion = "25.11";
}
