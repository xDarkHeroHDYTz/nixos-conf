{ config, pkgs, pkgs-stable, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./ai.nix
    ./audient.nix
    #./bluetooth.nix
    #./laptop.nix
    ./nuphy.nix
  ];

  # --- SISTEMA DE ARRANQUE Y KERNEL ---
  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
    initrd = {
      luks.devices."luks-2cf93f25-4b7b-4667-ba82-c2c25890cd2c".device = "/dev/disk/by-uuid/2cf93f25-4b7b-4667-ba82-c2c25890cd2c";
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
      theme = "breeze";
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
      "nvidia.NVreg_EnableGpuFirmware=1"
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    ];
    kernel.sysctl = {
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
      "vm.swappiness" = 10;
    };
  };

  # --- HARDWARE (NVIDIA Y COMPONENTES) ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };
  programs.low-latency-layer.enable = true;
  services.lact.enable = true;
  services.hardware.openrgb.enable = true;

  # --- MANTENIMIENTO Y RENDIMIENTO DE ALMACENAMIENTO ---
  fileSystems."/" = {
    options = [
      "noatime"
      "nodiratime"
      "commit=30"
      "errors=remount-ro"
    ];
  };
  services.fstrim.enable = true;
  services.irqbalance.enable = true;

  # --- CONFIGURACIÓN REGIONAL Y RED ---
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";

  # --- USUARIOS Y AUTOLOGIN ---
  users.users."lisandro" = {
    isNormalUser = true;
    description = "Lisandro Julian Roldán Barbato";
    extraGroups = [ "wheel" "libvirtd" "disk" "networkmanager" "video" "render" "audio" "gamemode" ];
  };
  services.getty.autologinUser = "lisandro";

  # --- ENTORNO GRÁFICO ---
  programs.niri.enable = true;

  # --- AUDIO Y PRIVILEGIOS REALTIME ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- SERVICIOS DEL SISTEMA, GAMING Y VIRTUALIZACIÓN ---
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.fwupd.enable = true;
  security.polkit.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.localsend.enable = true;
  programs.steam.enable = true;
  services.wivrn = {
    enable = true;
    package = pkgs.wivrn.override { cudaSupport = true; };
  };
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        reaper_freq = 5;
        desiredgov = "performance";
        desiredprof = "performance";
        igpu_power_threshold = -1;
        softrealtime = "off";
        renice = 0;
        ioprio = 0;
        inhibit_screensaver = 1;
        disable_splitlock = 1;
      };
      gpu = {
        apply_gpu_optimisations = 1;
        gpu_device = 0;
        nv_powermizer_mode = 1;
      };
      cpu = {
        park_cores = "no";
        pin_cores = "no";
      };
    };
  };

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
    xwayland-satellite
    zellij
  ];

  # --- CONFIGURACIÓN DE NIX / PAQUETES ---
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  system.stateVersion = "26.05";
}
