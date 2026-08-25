{ config, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop     = "${config.home.homeDirectory}/Escritorio";
      documents   = "${config.home.homeDirectory}/Documentos";
      download    = "${config.home.homeDirectory}/Descargas";
      music       = "${config.home.homeDirectory}/Música";
      pictures    = "${config.home.homeDirectory}/Imágenes";
      publicShare = "${config.home.homeDirectory}/Público";
      templates   = "${config.home.homeDirectory}/Plantillas";
      videos      = "${config.home.homeDirectory}/Videos";
    };
    desktopEntries = {
      nvim = {
        name = "Neovim";
        exec = "nvim";
        noDisplay = true;
      };
      nvim-nautilus = {
        name = "Neovim (Terminal)";
        genericName = "Editor de Texto";
        exec = "ghostty -e nvim %F";
        icon = "nvim";
        terminal = false;
        categories = [ "Utility" "TextEditor" ];
        mimeType = [ "text/plain" "application/x-shellscript" ];
      };
      bat-viewer = {
        name = "BAT Viewer (Terminal)";
        exec = "ghostty -e bat %F";
        icon = "text-editor";
        terminal = false;
        categories = [ "Utility" "TextEditor" ];
        mimeType = [ "text/x-log" ];
      };
      cliamp = {
        name = "Cliamp";
        genericName = "Reproductor de Música";
        exec = "ghostty -e cliamp ${config.xdg.userDirs.music}";
        icon = "multimedia-audio-player";
        terminal = false;
        categories = [ "AudioVideo" "Audio" "Player" ];
        mimeType = [ "audio/mpeg" "audio/flac" "audio/wav" "audio/ogg" ];
      };
      wiremix = {
        name = "Wiremix";
        genericName = "Control de Volumen";
        exec = "ghostty -e wiremix";
        icon = "multimedia-volume-control";
        terminal = false;
        categories = [ "AudioVideo" "Audio" "Mixer" ];
      };
      librewolf-private = {
        name = "LibreWolf (Privado)";
        genericName = "Navegador Web Privado";
        exec = "librewolf -p private";
        icon = "librewolf";
        terminal = false;
        categories = [ "Network" "WebBrowser" ];
        mimeType = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        # --- Texto, Código y Configuración (Neovim / Ghostty) ---
        "text/plain" = [ "nvim-nautilus.desktop" ];
        "text/markdown" = [ "obsidian.desktop" ];
        "text/x-nix" = [ "dev.zed.Zed.desktop" ];
        "application/x-shellscript" = [ "nvim-nautilus.desktop" ];
        "application/x-yaml" = [ "nvim-nautilus.desktop" ];
        "application/json" = [ "nvim-nautilus.desktop" ];
        "application/xml" = [ "nvim-nautilus.desktop" ];
        "text/css" = [ "nvim-nautilus.desktop" ];
        # --- Visualización de Texto por Terminal (bat) ---
        # Si creas una entrada .desktop para bat, puedes mapear lecturas rápidas:
        "text/x-log" = [ "bat-viewer.desktop" ];
        # --- Multimedia (Audio y Video) ---
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "audio/wav" = [ "mpv.desktop" ];
        "audio/ogg" = [ "mpv.desktop" ];
        "audio/x-wav" = [ "mpv.desktop" ];
        "application/x-kdenlive" = [ "org.kde.kdenlive.desktop" ];
        "audio/x-aup" = [ "audacity.desktop" ];
        # --- Imágenes y Gráficos ---
        "image/jpeg" = [ "imv-dir.desktop" ];
        "image/png" = [ "imv-dir.desktop" ];
        "image/webp" = [ "imv-dir.desktop" ];
        "image/gif" = [ "imv-dir.desktop" ];
        "image/heif" = [ "imv-dir.desktop" ];
        "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
        "image/x-xcf" = [ "gimp.desktop" ];
        "application/x-blender" = [ "blender.desktop" ];
        # --- Fotografía / Archivos RAW (Darktable) ---
        "image/x-canon-cr2" = [ "org.darktable.darktable.desktop" ];
        "image/x-canon-cr3" = [ "org.darktable.darktable.desktop" ];
        "image/x-nikon-nef" = [ "org.darktable.darktable.desktop" ];
        "image/x-sony-arw" = [ "org.darktable.darktable.desktop" ];
        "image/x-adobe-dng" = [ "org.darktable.darktable.desktop" ];
        "image/tiff"        = [ "org.darktable.darktable.desktop" ];
        # --- Archivos Comprimidos ---
        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
        "application/x-tar" = [ "org.kde.ark.desktop" ];
        "application/x-compressed-tar" = [ "org.kde.ark.desktop" ];
        # --- Documentos ---
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/epub+zip" = [ "libreoffice-writer.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "libreoffice-writer.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "libreoffice-writer.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "libreoffice-calc.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "libreoffice-impress.desktop" ];
        # --- Navegación y Protocolos ---
        "text/html" = [ "librewolf.desktop" ];
        "x-scheme-handler/http" = [ "librewolf.desktop" ];
        "x-scheme-handler/https" = [ "librewolf.desktop" ];
        "x-scheme-handler/about" = [ "librewolf.desktop" ];
        "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
        "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      };
    };
  };
}
