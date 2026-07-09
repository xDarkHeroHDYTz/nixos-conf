{ config, pkgs, pkgs-stable, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./audient.nix
    ./nuphy.nix
  ];

  # --- SISTEMA DE ARRANQUE Y KERNEL ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
  boot = {
    plymouth = {
      enable = true;
      theme = "breeze";
    };
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];
  };

  # --- CONFIGURACIÓN REGIONAL Y RED ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.extraCommands = ''
    iptables -A INPUT -s 192.168.68.0/24 -j ACCEPT
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D INPUT -s 192.168.68.0/24 -j ACCEPT 2>/dev/null || true
  '';

  # --- USUARIOS Y AUTOLOGIN ---
  users.users."lisandro" = {
    isNormalUser = true;
    description = "Lisandro Julian Roldán Barbato";
    extraGroups = [ "wheel" "libvirtd" "disk" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };
  services.getty.autologinUser = "lisandro";

  # --- HARDWARE (NVIDIA Y COMPONENTES) ---
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };
  services.hardware.openrgb.enable = true;
  services.lact.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  # --- ENTORNO GRÁFICO Y PORTALS OPTIMIZADOS PARA WAYLAND/NIRI ---
  services.gnome.gnome-keyring.enable = true;
  services.dbus.packages = with pkgs; [ gnome-keyring gsettings-desktop-schemas ];
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "gtk" ];
  };
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  programs.niri.enable = true;
  programs.fish.enable = true;

  # --- AUDIO Y CAPA DE PRIORIDAD ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.pam.loginLimits = [
    { domain = "@wheel"; type = "-"; item = "rtprio"; value = "95"; }
    { domain = "@wheel"; type = "-"; item = "memlock"; value = "unlimited"; }
  ];

  systemd.user.targets.niri-session = {
    unitConfig = {
      Description = "Niri graphical session";
      BindsTo = [ "graphical-session.target" ];
      Before = [ "graphical-session.target" ];
    };
  };

  # --- REGLA POLKIT ---
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.encrypted-unlock" ||
           action.id == "org.freedesktop.udisks2.encrypted-unlock-system") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # --- PAQUETES, GAMING Y VIRTUALIZACIÓN ---
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
      # --- SISTEMA, TERMINAL Y UTILIDADES ---
      aria2
      bat
      btop
      cava
      cmatrix
      ddcutil
      fastfetch
      fzf
      lmstudio
      p7zip
      smartmontools
      tmux
      tealdeer
      tty-clock
      wget
      wiremix
      xwayland-satellite
      # --- DESARROLLO Y EDITORES DE TEXTO ---
      lazygit
      neovim
      zed-editor
      # --- NAVEGADORES WEB ---
      librewolf
      # --- GAMING Y OPTIMIZACIÓN ---
      heroic
      hydralauncher
      mangohud
      r2modman
      pcsx2
      prismlauncher
      protonup-qt
      protontricks
      # --- MULTIMEDIA (AUDIO, VIDEO Y EDICIÓN) ---
      audacity
      cliamp
      ffmpeg
      gimp
      mpv
      kdePackages.kdenlive
      obs-cmd
      (obs-studio.override { cudaSupport = true; })
      vesktop
      yt-dlp
      # --- PRODUCTIVIDAD Y GESTIÓN DE ARCHIVOS ---
      kdePackages.kcalc
      kdePackages.okular
      libreoffice
      localsend
      nautilus
      obsidian
      yazi
      # --- PAQUETES CON CONFIGURACIONES ESPECIALES ---
      (roomeqwizard.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
        postInstall = (oldAttrs.postInstall or "") + ''
          wrapProgram $out/bin/roomeqwizard \
            --set _JAVA_AWT_WM_NONREPARENTING 1 \
            --add-flags "-Dsun.java2d.uiScale=1.0" \
            --add-flags "-Dsun.java2d.opengl=false"
        '';
      }))
    ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  # --- CONFIGURACIÓN DE NIX / PAQUETES ---
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "pnpm-10.29.2"
    ];
  };
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "lisandro" "@wheel" ];
    auto-optimise-store = true;
    max-jobs = "auto";
    cores = 0;
  };
  system.stateVersion = "26.05";
}
