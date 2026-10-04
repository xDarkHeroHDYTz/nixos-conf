{ pkgs, ... }:

{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = false;
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
      geary
      totem
      evince
      gnome-terminal
      gnome-console
      gnome-system-monitor
      gnome-text-editor
      gedit
      gnome-music
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
      vitals
    ]);
  };
}
