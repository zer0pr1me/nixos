{ pkgs, config, lib, ... }:

let
  utils = import ../lib/utils.nix { inherit lib; };
  userHome = config.home.homeDirectory;
in
{
  home.sessionVariables = {
    DISPLAY = ":0";
  };

  home.packages = [ pkgs.xwayland-satellite ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "battery" "tray" ];

        "clock" = {
          format = "{:%H:%M:%S | %a, %b %d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 1;
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo} ({capacity}%)";
        };

        "niri/workspaces" = {
          format = "{name}";
        };
      };
    };

    style = ''
      * {
        border: none;
        font-family: "JetBrainsMono NFM", "JetBrains Mono", monospace;
        font-size: 13px;
        font-weight: 500;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(20, 20, 20, 0.85);
        color: #ffffff;
      }

      #clock, #workspaces, #window, #tray {
        padding: 0 12px;
      }

      #clock {
        font-weight: bold;
        color: #89b4fa;
      }
    '';
  };

  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "us,ua";
          options = "ctrl:nocaps,grp:shifts_toggle";
        };
        track-layout = "global";
      };
    };

    spawn-at-startup = [
      { command = [ "${pkgs.waybar}/bin/waybar" ]; }
      { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+Return".action = spawn "ghostty";
      "Mod+D".action = spawn "fuzzel";
      "Mod+Q".action = close-window;
      "Mod+Shift+E".action = quit;

      # Navigation
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-or-workspace-up;
      "Mod+Down".action = focus-window-or-workspace-down;

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+J".action = focus-window-or-workspace-down;

      # Window Movement
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-to-workspace-up;
      "Mod+Shift+Down".action = move-window-to-workspace-down;

      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+K".action = move-window-to-workspace-up;
      "Mod+Shift+J".action = move-window-to-workspace-down;

      # Resizing
      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+C".action = center-column;
    };
  };

  home.activation.linkNiriDesktop = utils.mkNonNixosSymlink {
    sourcePath = "${userHome}/.local/share/wayland-sessions/niri.desktop";
    targetPath = "/usr/share/wayland-sessions/niri.desktop";
  };

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland satellite for Niri";
      BindsTo = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite :0";
      ExecStartPost = "${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
