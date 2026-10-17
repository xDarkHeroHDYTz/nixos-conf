{ pkgs, ... }:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = false;
  };

  programs.kde-pim.enable = false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
    khelpcenter
    elisa
    gwenview
    okular
    ark
    dolphin
    plasma-browser-integration
    kmahjongg
    kmines
    kpat
    ksudoku
    konversation
    ktorrent
    krdc
    krfb
  ];

  environment.etc."xdg/baloofilerc".text = ''
    [Basic Settings]
    Indexing-Enabled=false
  '';
}
