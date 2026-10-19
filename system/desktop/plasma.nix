{ pkgs, ... }:

{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = false;
  };

  programs.kde-pim.enable = false;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # --- Terminal, Editores y Gestores de Archivos ---
    konsole      # Reemplazado por Ghostty
    kate         # Reemplazado por Neovim / Zed
    kwrite       # Reemplazado por Neovim / Zed
    dolphin      # Reemplazado por Nautilus
    ark          # Reemplazado por File-roller (vía Nautilus)
    kfind        # Reemplazado por Nautilus / FZF

    # --- Multimedia y Visores ---
    elisa        # Reemplazado por Cliamp / MPV
    gwenview     # Reemplazado por IMV / Nautilus
    okular       # Reemplazado por Zathura / Okular en Home Manager si se requiere independiente
    dragon       # Reemplazado por MPV

    # --- Utilidades y Sistema ---
    kcalc          # Reemplazado por gnome-calculator
    kwalletmanager # Reemplazado por gnome-keyring
    khelpcenter
    plasma-browser-integration

    # --- Conectividad y Redes ---
    konversation
    ktorrent
    krdc
    krfb

    # --- Juegos preinstalados de KDE ---
    kmahjongg
    kmines
    kpat
    ksudoku
  ];

  environment.etc."xdg/baloofilerc".text = ''
    [Basic Settings]
    Indexing-Enabled=false
  '';
}
