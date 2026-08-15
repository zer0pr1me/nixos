{ pkgs, ... }:

{
  imports = [
    ../apps/git.nix
    ../apps/nemo.nix
    ../apps/niri.nix
    ../apps/helix.nix
    ../apps/syncthing.nix
  ];
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  nixpkgs.config = {
    allowUnfree = true;
  };
  home.packages = with pkgs; [
    discord

    tree
    nixd
    firefox
    ghostty
    fuzzel
    telegram-desktop
    python3
    uv
    obsidian
    usbutils

    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
