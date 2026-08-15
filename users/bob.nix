{ pkgs, ... }:

{
  imports = [
    ../apps/helix.nix
    ../apps/syncthing.nix
    ../apps/anamnesis.nix
  ];
  home.username = "bob";
  home.homeDirectory = "/home/bob";

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
