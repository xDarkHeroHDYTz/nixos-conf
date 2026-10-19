{ pkgs, ... }:

{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = false;
  };

  environment.cosmic.excludePackages = with pkgs; [
    # --- Editores, Terminales y Gestores de Archivos ---
    cosmic-term   # Reemplazado por Ghostty
    cosmic-edit   # Reemplazado por Neovim / Zed
    cosmic-files  # Reemplazado por Nautilus

    # --- Multimedia, Tienda y Utilidades ---
    cosmic-player # Reemplazado por MPV
    cosmic-randr
    cosmic-store  # Redundante (las aplicaciones se gestionan de forma declarativa con Nix/Flakes)
    cosmic-reader # Reemplazado por Zathura / Okular
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-cosmic
      pkgs.xdg-desktop-portal-gtk
    ];
    # Mapea COSMIC para que use sus propios portales de selección de pantalla
    config = {
      cosmic = {
        default = [ "cosmic" "gtk" ];
        "org.freedesktop.impl.portal.Screencast" = [ "cosmic" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "cosmic" ];
      };
    };
  };
}
