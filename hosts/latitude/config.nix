{
  pkgs,
  config,
  nixgl,
  lib,
  ...
}:

let
  nixGLPkg = nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLIntel;
  nixGL = "${nixGLPkg}/bin/nixGLIntel";
  niriSession = "${pkgs.niri}/bin/niri-session";
  userHome = config.home.homeDirectory;
in
{
  imports = [
    ../../apps/syncthing.nix
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
      };
    };
  };

  # TODO: copy or symlink `~/.local/share/wayland-sessions/niri.desktop` to `/usr/share/wayland-sessions`
  xdg.dataFile."wayland-sessions/niri.desktop".text = ''
    [Desktop Entry]
    Name=Niri
    Comment=Scrollable Tiling Wayland Compositor (Nix Managed)
    Exec=env PATH="${userHome}/.nix-profile/bin:/usr/local/bin:/usr/bin:/bin" XDG_CURRENT_DESKTOP=Niri XDG_SESSION_TYPE=wayland ${nixGL} ${niriSession}
    Type=Application
    DesktopNames=Niri
  '';

  programs.niri.enable = true;

  home.shellAliases = {
    ghostty = "nixGLIntel ghostty";
  };
  # Ensure Home Manager links systemd user services on non-NixOS hosts
  systemd.user.startServices = "sd-switch";

  # Point systemd user manager to Home Manager unit paths
  xdg.configFile."systemd/user/niri.service".source = "${pkgs.niri}/share/systemd/user/niri.service";
  xdg.configFile."systemd/user/niri-shutdown.target".source =
    "${pkgs.niri}/share/systemd/user/niri-shutdown.target";

  programs.niri.settings = {
    spawn-at-startup = [
      # Notify DBus & Systemd of the Wayland session variables
      {
        command = [
          "dbus-update-activation-environment"
          "--systemd"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_TYPE"
        ];
      }
    ];
  };
}
