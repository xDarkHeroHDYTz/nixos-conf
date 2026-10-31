{ pkgs, pkgs-stable, ... }:

{
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
    tpm2-tss
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  programs.localsend.enable = true;
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
}
