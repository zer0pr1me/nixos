{
  lib,
  ...
}:

let
  devices = {
    vivobook-s = {
      id = "77OLQKP-HSJUUYE-GXPLZA5-P4C2VR4-H23XWCX-HJ2FUGJ-UTHBJNC-IWPDEAI";
      addresses = [
        "tcp://192.168.8.43:22000"
        "dynamic"
      ];
    };
    cc = {
      id = "SQWPYRX-RP5PZVD-4XNLBZJ-MPYFAKO-YRTB226-FVSZVNO-UYJWNKS-ATFDIQS";
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
    "prima-materia" = {
      path = "/home/bohdan/sync/prima-materia";
      devices = [
        "cc"
        "vivobook-s"
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
      # Filter out 'latitude' so it doesn't try to connect to itself
      devices = lib.filterAttrs (name: _: name != "latitude") devices;

      # Filter out 'latitude' from target devices list for each folder
      folders = builtins.mapAttrs (
        name: folder:
        folder
        // {
          devices = builtins.filter (dev: dev != "latitude") folder.devices;
        }
      ) folders;

      # Keep unmanaged web GUI edits from being overwritten instantly if desired
      # overrideDevices = true;
      # overrideFolders = true;
    };
  };
}
