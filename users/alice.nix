{ pkgs, ... }:

{
  imports = [
    ../apps/nemo.nix
    ../apps/niri.nix
    ../apps/helix.nix
    ../apps/syncthing.nix
  ];
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
    tree
    nixd
    firefox
    ghostty
    fuzzel
    telegram-desktop
    python3
    uv
    obsidian

    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
