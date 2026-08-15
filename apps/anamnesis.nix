{ pkgs, anamnesis, config, ... }:

let
  homeRoot = config.home.homeDirectory;
  anamnesisPkg = anamnesis.packages.${pkgs.system}.default;
in
{
  # Install the CLI binary into your user PATH
  home.packages = [ anamnesisPkg ];

  # Configure the user-level background daemon
  systemd.user.services.anamnesis = {
    Unit = {
      Description = "Anamnesis Codex Reminder Daemon";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      ExecStart = "${anamnesisPkg}/bin/anamnesis";
      Restart = "always";
      RestartSec = "10s";

      EnvironmentFile = "${homeRoot}/.config/anamnesis/env";

    };

    Install = {
      WantedBy = [ "default.target" ]; # Starts automatically on user login
    };
  };
}
