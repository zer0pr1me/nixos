{
  lib,
  config,
  currentHost,
  ...
}:

let
  userHome = config.home.homeDirectory;
  devices = {
    vivobook = {
      id = "57JL6KW-HJYHTHA-WBMUTIB-MJIKY2J-D755FGW-TMTOK7E-GJ6J4NR-MHFPKAF";
      addresses = [
        "tcp://192.168.8.43:22000"
        "dynamic"
      ];
    };
    zeroprime-cc = {
      id = "IPPQAVG-BGHOIRU-HQICO65-MITXFVH-J4WIMBC-WETYGZT-FVCMEHA-QCJPVQF";
      addresses = [
        "tcp://192.168.8.42:22000"
        "dynamic"
      ];
    };
    latitude = {
      id = "J35OPP2-IJUNWUQ-HRJIWPY-JNSQKL6-M65LZPZ-ZHL4PSY-JQOWJPT-GTM57Q6";
      addresses = [
        "tcp://192.168.8.44:22000"
        "dynamic"
      ];
    };
  };
  folders = {
    "books" = {
      path = "${userHome}/sync/books";
      devices = [
        "zeroprime-cc"
        "vivobook"
        "latitude"
      ];
    };
    "codex" = {
      path = "${userHome}/sync/codex";
      devices = [
        "zeroprime-cc"
        "vivobook"
        "latitude"
      ];
    };
  };
in
{
  services.syncthing = {
    enable = true;

    # Syncthing GUI web interface port
    guiAddress = "127.0.0.1:8384";

    # Declarative Mesh Configuration
    settings = {
      devices = lib.filterAttrs (name: _: name != currentHost) devices;

      folders = builtins.mapAttrs (
        name: folder:
        folder
        // {
          devices = builtins.filter (dev: dev != currentHost) folder.devices;
        }
      ) folders;
    };
    overrideDevices = true;
    overrideFolders = true;
  };
}
