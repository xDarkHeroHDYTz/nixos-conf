{ pkgs, ... }:

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
    ../../system/hardware/nuphy.nix
    ../../system/hardware/nvidia.nix
    # ../../system/hardware/power.nix

    # Services
    #../../system/services/ai.nix
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

  # --- INTEL UNDERVOLT (Reduce temperaturas del i7-8750H) ---
  services.undervolt = {
    enable = true;
    coreOffset = -160;
    gpuOffset = -65;
    uncoreOffset = -70;
    temp = 90;
  };

  # --- HARDWARE GRÁFICO E INTEL VA-API ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  # --- NVIDIA PRIME ---
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    powerManagement = {
      finegrained = true;
    };
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # PERFILES DE ENERGIA
  services.upower.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        energy_performance_preference = "performance";
        turbo = "auto";
      };
    };
  };

  # --- PARAMETROS DE EFICIENCIA ENERGETICA ---
  boot.kernelParams = [
    "pcie_aspm.policy=powersupersave"
    "intel_pstate=active"
    "snd_hda_intel.power_save=1"
    "snd_hda_intel.power_save_controller=Y"
    "intel_idle.max_cstate=10"
    "i915.enable_fbc=1"
    "i915.enable_psr=1"
    "nmi_watchdog=0"
  ];

  # Garantiza que el audio HDMI y controladores USB-C de la RTX 2060 entren en D3cold
  services.udev.extraRules = ''
    # Discos SATA (si aplica)
    ACTION=="add", SUBSYSTEM=="scsi_disk", ATTR{manage_runtime_start_stop}="1"
    ACTION=="add", SUBSYSTEM=="scsi_disk", ATTR{manage_system_start_stop}="1"

    # Suspensión en tiempo de ejecución para todas las funciones PCI de NVIDIA (0x10de)
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto"
  '';

  # --- RED, LOCALIZACIÓN Y SEGURIDAD ---
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";

  # --- USUARIOS ---
  users.users."lisandro" = {
    isNormalUser = true;
    description = "Lisandro Julian Roldán Barbato";
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirtd" "render" "video" "audio" "gamemode" "i2c" "wireshark" ];
  };
  home-manager.users.lisandro = import ./home.nix;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  system.stateVersion = "26.05";
}
