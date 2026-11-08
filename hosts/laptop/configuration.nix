{ ... }:

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
    ../../system/hardware/power.nix

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

  boot.kernelParams = [
    "pcie_aspm=force"
    "snd_hda_intel.power_save=1"
    "intel_idle.max_cstate=10"
  ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="scsi_disk", ATTR{manage_suspend}="1"
  '';

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

  # --- RED, LOCALIZACIÓN Y SEGURIDAD ---
  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "es_AR.UTF-8";

  # --- USUARIOS Y AUTOLOGIN ---
  users.users."lisandro" = {
    isNormalUser = true;
    description = "Lisandro Julian Roldán Barbato";
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirtd" "render" "video" "audio" "disk" "gamemode" ];
  };
  home-manager.users.lisandro = import ./home.nix;

  # --- INTEL UNDERVOLT (Reduce temperaturas del i7-8750H) ---
  services.undervolt = {
    enable = true;
    coreOffset = -160;
    gpuOffset = -65;
    uncoreOffset = -70;
    temp = 90;
  };

  # --- NVIDIA PRIME ---
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  system.stateVersion = "26.05";
}
