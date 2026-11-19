{ pkgs, ... }:

{
  # Paquetes base instalados a nivel de todo el sistema operativo
  environment.systemPackages = with pkgs; [
    # --- Utilidades de Terminal & CLI ---
    bat
    fastfetch
    fzf
    neovim
    tealdeer
    tree
    wget
    zellij

    # --- Hardware, Discos & Monitores ---
    ddcutil
    nvme-cli
    smartmontools

    # --- Seguridad, Cifrado & Boot ---
    cryptsetup
    sbctl
    tpm2-tools
  ];

  hardware.i2c.enable = true;

  programs.localsend.enable = true;
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
}
