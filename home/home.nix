{ pkgs, pkgs-stable, inputs, ... }:

{
  home.username = "lisandro";
  home.homeDirectory = "/home/lisandro";

  imports = [
    ./pkgconf/git.nix
    ./pkgconf/gtk.nix
    ./pkgconf/nautilus.nix
    ./pkgconf/neovim.nix
    ./pkgconf/niri.nix
    ./pkgconf/noctalia.nix
    ./pkgconf/qt.nix
    ./pkgconf/steam-millennium.nix
    ./pkgconf/terminal.nix
    ./pkgconf/xdg.nix
    ./pkgconf/zed.nix
  ];

  home.sessionVariables = {
    # --- NVIDIA & DRIVERS ---
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    # --- NVIDIA RENDERING & THREADING ---
    __GL_THREADED_OPTIMIZATION = "1";
    __GL_MaxFramesAllowed = "1";
    # --- NVIDIA G-SYNC / REFRESH RATE ---
    __GL_SYNC_TO_VBLANK = "0";
    # --- WAYLAND & TOOLKITS ---
    MOZ_ENABLE_WAYLAND = "1";
    # --- PROTON, WAYLAND & DLSS/FSR ---
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_ENABLE_NVAPI = "1";
    PROTON_ENABLE_NGX_UPDATES = "1";
    PROTON_DLSS_UPGRADE = "1";
    PROTON_FSR4_UPGRADE = "1";
    # --- LATENCIA & FRAMEPACING ---
    PROTON_DXVK_LOWLATENCY = "1";
    LOW_LATENCY_LAYER = "1";
    LOW_LATENCY_LAYER_REFLEX = "1";
    # --- CACHE DE SHADERS ---
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    __GL_SHADER_DISK_CACHE_SIZE = "10737418240";
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        export CLUTTER_BACKEND="wayland"
        export SDL_VIDEODRIVER="wayland"
        export QT_QPA_PLATFORM="wayland-egl"
        export ECORE_EVAS_ENGINE="wayland_egl"
        export ELM_ENGINE="wayland_egl"
        exec systemd-cat --identifier=niri dbus-run-session niri --session
      fi
    '';
  };

  home.packages = with pkgs; [
    # --- TERMINAL Y PRODUCTIVIDAD CLI ---
    aria2
    cava
    cmatrix
    fetch
    gh
    lazygit
    p7zip
    tmux
    tty-clock
    wiremix
    yt-dlp
    # --- NAVEGACIÓN, DESARROLLO Y LENGUAJES ---
    librewolf
    zed-editor
    nil
    nixd
    # --- GAMING ---
    goverlay
    heroic
    hydralauncher
    mangohud
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
    exiftool
    ffmpeg
    gimp
    imv
    kdePackages.kdenlive
    libheif
    libheif.out
    librsvg
    mpv
    (obs-studio.override { cudaSupport = true; })
    rembg
    vesktop
    # --- PRODUCTIVIDAD, GESTIÓN Y UTILIDADES ---
    gnome-calculator
    gnome-disk-utility
    kdePackages.okular
    libreoffice
    obsidian
    # --- TIPOGRAFÍAS ---
    nerd-fonts.jetbrains-mono
    # --- INTEGRACIONES Y OVERRIDES ---
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  home.stateVersion = "26.05";
}
