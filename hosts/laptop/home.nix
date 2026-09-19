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

  # home.sessionVariables = {
  #   # --- NVIDIA & RENDERING (Mínima Latencia) ---
  #   LIBVA_DRIVER_NAME = "nvidia";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #   __GL_THREADED_OPTIMIZATION = "1";
  #   __GL_MaxFramesAllowed = "1";
  #   __GL_SYNC_TO_VBLANK = "0";
  #   __GL_VRR_ALLOWED = "1";
  #   __GL_GSYNC_ALLOWED = "1";
  #   # --- TOOLKITS & WAYLAND NATIVO ---
  #   QT_QPA_PLATFORM = "wayland;xcb";
  #   SDL_VIDEODRIVER = "wayland,x11";
  #   CLUTTER_BACKEND = "wayland";
  #   NIXOS_OZONE_WL = "1";
  #   ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  #   # --- PROTON & JUEGOS ---
  #   PROTON_ENABLE_WAYLAND = "1";
  #   PROTON_ENABLE_NVAPI = "1";
  #   DXVK_NVAPI_VKREFLEX = "1";
  #   PROTON_ENABLE_NGX_UPDATES = "1";
  #   PROTON_DLSS_UPGRADE = "1";
  #   PROTON_FSR4_UPGRADE = "1";
  #   PROTON_DXVK_LOWLATENCY = "1";
  #   # --- CAPA DE LATENCIA VULKAN (Reflex Emulation) ---
  #   LOW_LATENCY_LAYER = "1";
  #   LOW_LATENCY_LAYER_REFLEX = "1";
  #   # --- CACHÉ DE SHADERS (10GB) ---
  #   __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  #   __GL_SHADER_DISK_CACHE_SIZE = "10737418240";
  # };

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
    goverlay
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
