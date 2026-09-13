{ pkgs, pkgs-stable, ... }:

{
  programs.localsend.enable = true;

  environment.systemPackages = with pkgs; [
    bat
    btop-cuda
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
}
