{ pkgs, ... }:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = false;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
    khelpcenter
    elisa
    gwenview
    okular
    ark
    dolphin
  ];
}
