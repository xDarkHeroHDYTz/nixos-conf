{ pkgs, ... }:

{
  programs.niri.enable = true;

  environment = {
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
