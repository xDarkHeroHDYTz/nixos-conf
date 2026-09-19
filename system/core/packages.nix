{ pkgs, pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    ddcutil
    fastfetch
    fzf
    neovim
    nvme-cli
    smartmontools
    tealdeer
    tree
    wget
    zellij
  ];

  programs.localsend.enable = true;
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
}
