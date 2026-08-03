{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "vivobook-s" = {
          id = "77OLQKP-HSJUUYE-GXPLZA5-P4C2VR4-H23XWCX-HJ2FUGJ-UTHBJNC-IWPDEAI";
        };
        "cc" = {
          id = "SQWPYRX-RP5PZVD-4XNLBZJ-MPYFAKO-YRTB226-FVSZVNO-UYJWNKS-ATFDIQS";
          addresses = [
            "tcp://192.168.8.42:22000"
            "dynamic"
          ];
        };
      };
      folders = {
        "prima-materia" = {
          path = "~/prima-materia";
          devices = [ "vivobook-s" "cc" ];
        };
      };
    };
  };
}
