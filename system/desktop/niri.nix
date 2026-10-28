{ pkgs, ... }:

{
  programs.niri.enable = true;

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
