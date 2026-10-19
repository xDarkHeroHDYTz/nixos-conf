{ pkgs, ... }:

{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = false;
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      # --- Navegador, Correo y Multimedia Base ---
      gnome-tour
      epiphany # Reemplazado por LibreWolf
      geary
      totem    # Reemplazado por MPV
      evince   # Reemplazado por Zathura / Okular
      gnome-music # Reemplazado por Cliamp

      # --- Terminales y Editores (Reemplazados por Ghostty, Neovim y Zed) ---
      gnome-terminal
      gnome-console
      gnome-text-editor
      gedit

      # --- Monitorización y Diagnóstico (Reemplazado por btop) ---
      gnome-system-monitor
      gnome-logs

      # --- Aplicaciones Personales y Accesorios Redundantes ---
      gnome-contacts
      gnome-maps
      gnome-weather
      gnome-clocks
      gnome-calendar
      gnome-characters
      yelp                 # Visor de ayuda y documentación
      rygel                # Servidor multimedia UPnP/DLNA
      gnome-remote-desktop # Escritorio remoto integrado
    ];

    systemPackages = with pkgs; [
      gnome-extension-manager
    ] ++ (with pkgs.gnomeExtensions; [  # GNOME extensions, reboot to apply.
      appindicator
      blur-my-shell
      clipboard-indicator
      dash-to-dock
      just-perfection
      tiling-assistant
      # vitals
    ]);
  };
}
