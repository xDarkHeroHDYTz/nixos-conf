{ pkgs, ... }:

{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = false;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-term
    cosmic-edit
    # cosmic-files
    cosmic-player
    cosmic-randr
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
