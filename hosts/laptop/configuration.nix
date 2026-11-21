{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./theme.nix

    # Core
    ../../system/core/autoupgrade.nix
    ../../system/core/boot.nix
    ../../system/core/packages.nix

    # Desktop
    # ../../system/desktop/cosmic.nix
    # ../../system/desktop/gnome.nix
    ../../system/desktop/niri.nix
    # ../../system/desktop/plasma.nix

    # Greeter
    ../../system/greeter/greetd.nix

    # Hardware
    ../../system/hardware/audient.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/network-hardened.nix
    ../../system/hardware/nuphy.nix
    ../../system/hardware/nvidia.nix
    ../../system/hardware/power.nix

    # Services
    # ../../system/services/ai.nix
    ../../system/services/audio.nix
    ../../system/services/flatpak.nix
    ../../system/services/gaming.nix
    ../../system/services/keyring.nix
    ../../system/services/nix.nix
    # ../../system/services/remote.nix
    ../../system/services/stylix.nix
    ../../system/services/system.nix
    ../../system/services/virtualization.nix
  ];

  # --- IDENTIDAD, RED Y LOCALIZACIÓN ---
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";

  # --- MEMORIA Y ALMACENAMIENTO ---
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 5;
  };

  services.fstrim.enable = true;

  # --- ENERGÍA, TÉRMICA Y CPU (i7-8750H + TLP) ---
  services.undervolt = {
    enable = true;
    coreOffset = -160;
    gpuOffset = -65;
    uncoreOffset = -70;
    temp = 90;
  };

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = lib.mkForce false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # En batería corta el Turbo y limita al 65 % para priorizar autonomía
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 65;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      # Se excluye NVIDIA para que la gestione el driver con RTD3 (se conserva mei_me del valor por defecto de TLP)
      RUNTIME_PM_DRIVER_DENYLIST = "mei_me nouveau nvidia";

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "auto";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1;
      USB_EXCLUDE_BTUSB = 1;
      USB_EXCLUDE_PHONE = 1;
    };
  };

  # --- GRÁFICOS (INTEL iGPU + NVIDIA PRIME OFFLOAD) ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement = {
      finegrained = true;
    };
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # --- KERNEL Y UDEV ---
  boot.kernelParams = [
    "pcie_aspm.policy=powersupersave"
    "intel_pstate=active"
    "snd_hda_intel.power_save=1"
    "snd_hda_intel.power_save_controller=Y"
    "intel_idle.max_cstate=10"
    "i915.enable_fbc=1"
    "i915.enable_psr=1"
    "i915.fastboot=1"
    "nmi_watchdog=0"
  ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="scsi_disk", ATTR{manage_runtime_start_stop}="1"
    ACTION=="add", SUBSYSTEM=="scsi_disk", ATTR{manage_system_start_stop}="1"
  '';

  # --- USUARIOS Y PROGRAMAS ---
  users.users = {
    "lisandro" = {
      isNormalUser = true;
      description = "Lisandro Julian Roldán Barbato";
      extraGroups = [ "wheel" "networkmanager" "kvm" "libvirtd" "render" "video" "audio" "gamemode" "i2c" "wireshark" ];
    };
  };

  home-manager.users = {
    lisandro = import ./lisandro.nix;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  system.stateVersion = "26.05";
}
