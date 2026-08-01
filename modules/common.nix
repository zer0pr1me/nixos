{ config, pkgs, ... }:

{
  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking baseline
  networking.networkmanager.enable = true;

  # Time & Locale
  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";

  # Global Keymap Settings
  services.xserver.xkb = {
    layout = "us,ua";
    options = "ctrl:nocaps,grp:shifts_toggle";
  };
  console.useXkbConfig = true;

  # Standard base system packages across both nodes
  environment.systemPackages = with pkgs; [
    helix
    git
    wget
  ];

  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;
}
