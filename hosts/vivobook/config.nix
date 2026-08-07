{ config, pkgs, ... }:

{
  imports = [ ../../modules/syncthing.nix ];
  networking.hostName = "vivobook";

  # EFI Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # GPU & Display drivers
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Niri Desktop
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # User definition
  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Syncthing setup for Laptop
  services.syncthing = {
    user = "alice";
    dataDir = "/home/alice";
    configDir = "/home/alice/.config/syncthing";
  };

  system.stateVersion = "26.05";
}
