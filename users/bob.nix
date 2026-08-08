{ pkgs, ... }:

{
  imports = [
    ../apps/helix.nix
    ../apps/syncthing.nix
  ];
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
