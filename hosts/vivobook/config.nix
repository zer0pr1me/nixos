{ config, pkgs, ... }:

{
  networking.hostName = "nixos";

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
    packages = with pkgs; [
      tree
      nixd
      nixpkgs-fmt
      pyright
      ruff
      firefox
      ghostty
      fuzzel
      telegram-desktop
      python3
      uv
      obsidian
    ];
  };

  # Syncthing setup for Laptop
  services.syncthing = {
    enable = true;
    user = "alice";
    openDefaultPorts = true;
    dataDir = "/home/alice";
    configDir = "/home/alice/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      options = {
        listenAddresses = [
          "tcp://0.0.0.0:22001"
          "quic://0.0.0.0:22001"
        ];
      };
      devices = {
        "cc" = {
          id = "SQWPYRX-RP5PZVD-4XNLBZJ-MPYFAKO-YRTB226-FVSZVNO-UYJWNKS-ATFDIQS";
          addresses = [
            "tcp://192.168.8.42:22000"
            "dynamic"
          ];
        };
      };
      folders = {
        "prima-materia" = {
          path = "/home/alice/prima-materia";
          devices = [ "cc" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22001 ];
  networking.firewall.allowedUDPPorts = [ 22001 ];

  system.stateVersion = "26.05";
}
