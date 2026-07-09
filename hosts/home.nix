{ config, pkgs, pkgs-stable, inputs, ... }:

{
  home.username = "lisandro";
  home.homeDirectory = "/home/lisandro";

  imports = [
    ../packages/git.nix
    ../packages/niri.nix
    ../packages/noctalia.nix
    ../packages/steam-millennium.nix
    ../packages/terminal.nix
    ../packages/themes.nix
  ];

  home.packages = [ inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      ns = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos";
      cg = "sudo nix-collect-garbage -d";
    };
    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        export XDG_SESSION_TYPE=wayland
        export GBM_BACKEND=nvidia-drm
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export MOZ_ENABLE_WAYLAND=1
        export NIXOS_OZONE_WAYLAND=1
        exec systemd-cat --identifier=niri dbus-run-session niri --session
      fi
    '';
  };

  home.stateVersion = "26.05";
}
