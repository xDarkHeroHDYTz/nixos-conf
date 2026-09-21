{ inputs, pkgs, pkgs-stable, ... }:

{
  home.username = "lisandro";
  home.homeDirectory = "/home/lisandro";

  imports = [
    inputs.niri.homeModules.niri
    ../../home/niri/settings-laptop.nix

    ../../home/pkgconf/gaming-variables.nix
    ../../home/pkgconf/git.nix
    # ../../home/pkgconf/librewolf.nix
    ../../home/pkgconf/mangohud.nix
    ../../home/pkgconf/nautilus.nix
    ../../home/pkgconf/neovim.nix
    ../../home/pkgconf/noctalia.nix
    ../../home/pkgconf/terminal.nix
    ../../home/pkgconf/vesktop.nix
    ../../home/pkgconf/xdg.nix
    ../../home/pkgconf/zed-editor.nix
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
    vesktop.enable = true;
  };

  home.packages = with pkgs; [
    # --- TERMINAL Y PRODUCTIVIDAD CLI ---
    cmatrix
    fetch
    p7zip
    tty-clock
    wiremix

    # --- NAVEGACIÓN, DESARROLLO Y LENGUAJES ---
    librewolf
    nil
    nixd

    # --- GAMING ---
    faugus-launcher
    hydralauncher
    prismlauncher
    protonplus
    protontricks
    r2modman
    retroarch-full
    retroarch-assets
    retroarch-joypad-autoconfig

    # --- MULTIMEDIA (AUDIO, VIDEO, IMAGEN Y EDICIÓN) ---
    audacity
    (blender.override { cudaSupport = true; })
    cliamp
    darktable
    exiftool
    ffmpeg
    gimp
    inkscape
    kdePackages.kdenlive
    libheif
    libheif.out
    librsvg
    rembg

    # --- PRODUCTIVIDAD, GESTIÓN Y UTILIDADES ---
    gnome-calculator
    gnome-disk-utility
    kdePackages.okular
    libreoffice

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
