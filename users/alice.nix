{ pkgs, ... }:

{
  imports = [
    ../apps/niri.nix
  ];
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
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

    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
