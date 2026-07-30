{ ... }:

{
  xdg.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # --- Texto y Código ---
      "text/plain" = [ "nvim-nautilus.desktop" ];
      "application/x-shellscript" = [ "nvim-nautilus.desktop" ];

      # --- Multimedia ---
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];

      # --- Imágenes ---
      "image/jpeg" = [ "imv-dir.desktop" ];
      "image/png" = [ "imv-dir.desktop" ];
      "image/webp" = [ "imv-dir.desktop" ];
      "image/gif" = [ "imv-dir.desktop" ];

      # --- Documentos ---
      "application/pdf" = [ "org.kde.okular.desktop" ]; # Okular es mejor para PDF que LibreOffice
      "application/epub+zip" = [ "libreoffice-writer.desktop" ];
      "application/vnd.oasis.opendocument.text" = [ "libreoffice-writer.desktop" ];

      # --- Navegación ---
      "text/html" = [ "librewolf.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
      "x-scheme-handler/about" = [ "librewolf.desktop" ];
      "x-scheme-handler/unknown" = [ "librewolf.desktop" ];
    };
  };

  xdg.desktopEntries = {
    # Editor de texto usando Ghostty
    nvim-nautilus = {
      name = "Neovim (Terminal)";
      genericName = "Editor de Texto";
      exec = "ghostty -e nvim %F";
      icon = "nvim";
      terminal = false;
      categories = [ "Utility" "TextEditor" ];
      mimeType = [ "text/plain" "application/x-shellscript" ];
    };

    # Wrapper oculto para mantener compatibilidad
    nvim = {
      name = "Neovim";
      exec = "nvim";
      noDisplay = true;
    };
  };
}
