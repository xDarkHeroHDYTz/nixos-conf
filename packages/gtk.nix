{ pkgs, ... }:

{
  gtk = {
    enable = true;

    # 1. Estilo de widgets
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    # 2. Tema de íconos
    iconTheme = {
      name = "mate";
      package = pkgs.mate-icon-theme;
    };
    # 3. Cursor
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    # 4. Tipografía principal GTK
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };
  };

  home.packages = with pkgs; [
    nwg-look
    glib
  ];
}
