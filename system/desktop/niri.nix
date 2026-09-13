{ pkgs, ... }:

{
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # Servicios del sistema
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
