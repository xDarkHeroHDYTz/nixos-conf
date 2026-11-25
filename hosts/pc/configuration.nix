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
    # ../../system/hardware/bluetooth.nix
    # ../../system/hardware/network-hardened.nix
    ../../system/hardware/nuphy.nix
    ../../system/hardware/nvidia.nix
    ../../system/hardware/power.nix

    # Services
    ../../system/services/audio.nix
    ../../system/services/flatpak.nix
    ../../system/services/gaming.nix
    ../../system/services/keyring.nix
    ../../system/services/nix.nix
    ../../system/services/ollama.nix
    # ../../system/services/remote.nix
    ../../system/services/stylix.nix
    ../../system/services/system.nix
    ../../system/services/virtualization.nix
  ];

  # --- IDENTIDAD, RED Y LOCALIZACIÓN ---
  networking = {
    hostName = "pc";
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

  # --- CPU, ARRANQUE Y GRÁFICOS (RYZEN + NVIDIA) ---
  # Carga temprana de módulos NVIDIA para evitar conflictos visuales con Plymouth
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  boot.kernelParams = [
    "split_lock_detect=off"
  ];

  # Control de curva/ventilación de GPU y RGB
  services.lact.enable = true;
  services.hardware.openrgb.enable = true;

  # --- USUARIOS Y HOME MANAGER ---
  users.users = {
    "lisandro" = {
      isNormalUser = true;
      description = "Lisandro Julian Roldán Barbato";
      extraGroups = [ "wheel" "networkmanager" "kvm" "libvirtd" "render" "video" "audio" "gamemode" "i2c" ];
    };
  };

  home-manager.users = {
    lisandro = import ./lisandro.nix;
  };

  system.stateVersion = "26.05";
}
