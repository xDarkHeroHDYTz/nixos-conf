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

  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 5;
    };

    fstrim.enable = true;

    # Control de curva/ventilación de GPU y RGB
    lact.enable = true;
    hardware.openrgb.enable = true;
  };

  # --- CPU, ARRANQUE Y GRÁFICOS (RYZEN + NVIDIA) ---
  # Carga temprana de módulos NVIDIA para evitar conflictos visuales con Plymouth
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  boot.kernelParams = [
    "split_lock_detect=off"
    "mem_sleep_default=deep"
    # El fbdev de nvidia-drm reserva el framebuffer con el modo más grande
    # (3840x2160 del LG) pero dibuja la consola con el modo más chico
    # (2560x1440 del AOC), así que el greeter queda en la esquina superior
    # izquierda del LG. Fijamos ambos conectores en 2560x1440, que es la
    # resolución nativa real de los dos monitores.
    "video=DP-2:2560x1440"
    "video=DP-3:2560x1440"
  ];

  # --- USUARIOS Y HOME MANAGER ---
  users.users = {
    "lisandro" = {
      isNormalUser = true;
      description = "Lisandro Julian Roldán Barbato";
      extraGroups = [
        "wheel"
        "networkmanager"
        "kvm"
        "libvirtd"
        "render"
        "video"
        "audio"
        "gamemode"
        "i2c"
      ];
    };
  };

  home-manager.users = {
    lisandro = import ./lisandro.nix;
  };

  system.stateVersion = "26.05";
}
