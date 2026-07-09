{ config, pkgs, ... }:

{
  # 1. Variables de entorno unificadas
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    XDG_CURRENT_DESKTOP = "niri";
  };

  # 2. Configurar la base de GTK usando adw-gtk3
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark-Noctalia"; # <-- Nombre personalizado para tu copia local mutable
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # 3. Redirigir de forma mutable el CSS de GTK hacia los archivos dinámicos de Noctalia
  xdg.configFile."gtk-3.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/gtk-3.0/noctalia.css";
  xdg.configFile."gtk-4.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/gtk-4.0/noctalia.css";

  # 4. Instalar las herramientas de interfaz esenciales (incluyendo los esquemas)
  home.packages = with pkgs; [
    nwg-look               # El reemplazo de lxappearance recomendado para adw-gtk3
    qt6Packages.qt6ct      # El configurador oficial para Qt6
    glib                   # Para asegurarnos el comando gsettings nativo
    papirus-folders        # Requerido por el script de DekoDX
  ];
}
