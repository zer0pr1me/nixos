{ pkgs, ... }:

{
  imports = [
    ../apps/niri.nix
  ];
  home.username = "bohdan";
  home.homeDirectory = "/home/bohdan";

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nixd
    nixpkgs-fmt
    ghostty
    fuzzel

    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "26.05";
}
