{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Core
    ../../system/core/boot.nix
    ../../system/core/nix.nix
    ../../system/core/packages.nix

    # Desktop
    ../../system/desktop/niri.nix

    # Greeter
    ../../system/greeter/greetd.nix

    # Hardware
    ../../system/hardware/audient.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/nuphy.nix
    ../../system/hardware/nvidia.nix

    # Services
    #../../system/services/ai.nix
    ../../system/services/gaming.nix
    ../../system/services/virtualisation.nix
  ];

  # --- MEMORIA Y ALMACENAMIENTO ---
  zramSwap = {
    enable = true;
    memoryPercent = 50;
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
    extraGroups = [ "wheel" "libvirtd" "disk" "networkmanager" "video" "render" "audio" "gamemode" ];
  };
  home-manager.users.lisandro = import ./home.nix;

  # --- INTEL UNDERVOLT (Reduce temperaturas del i7-8750H) ---
  services.undervolt = {
    enable = true;
    coreOffset = -165;
    gpuOffset = -65;
    uncoreOffset = -65;
    temp = 90;
  };

  # --- NVIDIA PRIME ---
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.nvidia = {
    powerManagement.finegrained = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  system.stateVersion = "26.05";
}
