{ pkgs, ... }:

{
  home.username = "bohdan";
  home.homeDirectory = "/home/bohdan";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    superfile
  ];
}
