{ pkgs, ... }:

{
  imports = [
    ../apps/anamnesis.nix
    ../apps/git.nix
    ../apps/helix.nix
    ../apps/syncthing.nix
  ];
  home.username = "bob";
  home.homeDirectory = "/home/bob";

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
