{ pkgs, lib, ... }:

{
  # Explorador de archivos Nautilus + dependencias.
  home.packages = with pkgs; [
    (symlinkJoin {
      name = "nautilus-with-plugins";
      paths = [ nautilus ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/nautilus \
          --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "${
            lib.makeSearchPath "lib/gstreamer-1.0" [
              gst_all_1.gst-plugins-base
              gst_all_1.gst-plugins-good
              gst_all_1.gst-plugins-bad
              gst_all_1.gst-libav
            ]
          }"
      '';
    })
    file-roller
    ffmpegthumbnailer
    poppler
  ];

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
