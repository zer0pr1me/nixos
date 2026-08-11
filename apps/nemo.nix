{ config, pkgs, ... }:

{
  # 1. Enable dconf so Nemo can read/write settings
  dconf.enable = true;

  # 2. Add Nemo to user packages
  home.packages = with pkgs; [
    pkgs.nemo # or pkgs.nemo
    
    # Recommended additions for full functionality:
    pkgs.folder-color-switcher # Folder color customization
    file-roller                     # Archive extraction/creation context menu integration
    ffmpegthumbnailer # Video thumbnails
    poppler           # PDF thumbnails
    webp-pixbuf-loader # WebP image previews
  ];

  xdg.mimeApps = {
  enable = true;
  defaultApplications = {
    "inode/directory" = [ "nemo.desktop" ];
  };
};

  # 3. (Optional) Customize Nemo preferences directly via dconf
  dconf.settings = {
    "org/nemo/preferences" = {
      show-hidden-files = true;
      default-folder-viewer = "list-view"; # 'icon-view', 'list-view', or 'compact-view'
      show-full-path-titles = true;
      confirm-trash = false;
    };
    "org/nemo/window-state" = {
      start-with-dual-pane = false;
      side-pane-view = "places";
    };
  };
}
