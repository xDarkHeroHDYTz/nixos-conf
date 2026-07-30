{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    file-roller
    sushi
    gnome-desktop
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    ffmpegthumbnailer
    poppler
    webp-pixbuf-loader
  ];

  # Ajustes de comportamiento y privacidad
  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-view = "list-view";
      show-delete-permanently = true;
    };
    "org/gnome/desktop/privacy" = {
      remember-recent-files = true;
    };
  };
}
