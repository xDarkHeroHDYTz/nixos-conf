{ inputs, pkgs, ... }:

let
  usuario = "lisandro";
in
{
  home.username = usuario;
  home.homeDirectory = "/home/${usuario}";

  imports = [
    # Configuracion del entorno de escritorio
    inputs.niri.homeModules.niri
    ../../home/niri/settings-pc.nix
    ../../home/pkgconf/noctalia.nix

    # Configuracion de programas
    # ../../home/pkgconf/cybersecurity.nix
    ../../home/pkgconf/gaming-variables.nix
    ../../home/pkgconf/git.nix
    ../../home/pkgconf/librewolf.nix
    ../../home/pkgconf/mangohud.nix
    # ../../home/pkgconf/millenium.nix
    ../../home/pkgconf/nautilus.nix
    ../../home/pkgconf/neovim.nix
    ../../home/pkgconf/opencode.nix
    ../../home/pkgconf/terminal.nix
    ../../home/pkgconf/vesktop.nix
    ../../home/pkgconf/xdg.nix
    ../../home/pkgconf/zed-editor.nix

    # Secretos
    inputs.sops-nix.homeManagerModules.sops
    ../../home/secrets/secrets.nix
  ];

  programs = {
    btop = {
      enable = true;
      package = pkgs.btop.override { cudaSupport = true; };
    };
    cava.enable = true;
    lazygit.enable = true;
    mpv.enable = true;
    obsidian.enable = true;
    zathura.enable = true;
    aria2.enable = true;
    gh.enable = true;
    imv.enable = true;
    yt-dlp.enable = true;
    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override { cudaSupport = true; };
    };
  };

  home.packages = with pkgs; [
    # --- DESARROLLO Y LENGUAJES ---
    nil
    nixd

    # --- GAMING ---
    faugus-launcher
    hydralauncher
    pcsx2
    prismlauncher
    protonplus
    protontricks
    r2modman
    (retroarch.withCores (cores: with cores; [
      beetle-psx-hw   # PS1 con renderizado por hardware
      flycast         # Dreamcast
      mupen64plus     # N64 (mupen64plus-next)
      snes9x          # SNES
      mgba            # GBA
    ]))
    retroarch-assets
    retroarch-joypad-autoconfig

    # --- MULTIMEDIA (AUDIO, VIDEO, IMAGEN Y EDICIÓN) ---
    audacity
    cadcraft
    cliamp
    designcraft
    effectcraft
    exiftool
    ffmpeg
    filmcraft
    lightcraft
    photocraft
    rembg
    soundcraft
    vectorcraft

    # --- PRODUCTIVIDAD, GESTIÓN Y UTILIDADES ---
    gnome-calculator
    gnome-disk-utility
    libreoffice

    # --- TERMINAL Y PRODUCTIVIDAD CLI ---
    cmatrix
    fetch
    p7zip
    tty-clock
    wiremix

    # --- OVERRIDES ---
    (roomeqwizard.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/roomeqwizard \
          --set _JAVA_AWT_WM_NONREPARENTING 1 \
          --add-flags "-Dsun.uiScale=1.0" \
          --add-flags "-Dsun.java2d.opengl=false"
      '';
    }))
  ];

  home.stateVersion = "26.05";
}
