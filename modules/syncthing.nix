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
          addresses = [
            "tcp://192.168.8.43:22000"
            "dynamic"
          ];
        };
        "cc" = {
          id = "SQWPYRX-RP5PZVD-4XNLBZJ-MPYFAKO-YRTB226-FVSZVNO-UYJWNKS-ATFDIQS";
          addresses = [
            "tcp://192.168.8.42:22000"
            "dynamic"
          ];
        };
        "latitude" = {
          id = "J35OPP2-IJUNWUQ-HRJIWPY-JNSQKL6-M65LZPZ-ZHL4PSY-JQOWJPT-GTM57Q6";
          addresses = [
            "tcp://192.168.8.44:22000"
            "dynamic"
          ];
        };
      };
      folders = {
        "prima-materia" = {
          path = "~/prima-materia";
          devices = [
            "vivobook-s"
            "cc"
            "latitude"
          ];
        };
      };
    };
  };
}
