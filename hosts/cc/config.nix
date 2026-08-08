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
    linger = true;
  };

  # SSH Service
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  system.stateVersion = "25.11";
}
