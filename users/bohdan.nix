{ pkgs, config, ... }:

{
  imports = [
    ../apps/niri.nix
    ../apps/helix.nix
  ];
  home.username = "bohdan";
  home.homeDirectory = "/home/bohdan";

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };
  home.packages = with pkgs; [
    discord

    nixd
    nixpkgs-fmt
    ghostty
    fuzzel
    xwayland
    xwayland-satellite

    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "26.05";

  # Add Nix profile binaries to session PATH automatically
  home.sessionPath = [
    "${config.home.homeDirectory}/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
  ];

  # Enable shell integration so environment variables are sourced on login
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Source Nix profile if available
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix.sh'
      fi
    '';
  };
}
