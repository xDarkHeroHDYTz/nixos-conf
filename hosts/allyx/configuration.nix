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
    # ../../system/desktop/niri.nix
    ../../system/desktop/plasma.nix

    # Greeter
    # ../../system/greeter/greetd.nix

    # Hardware
    # ../../system/hardware/audient.nix
    ../../system/hardware/bluetooth.nix
    # ../../system/hardware/nuphy.nix
    # ../../system/hardware/nvidia.nix
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
    hostName = "allyx";
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

  programs.gamescope = {
    enable = true;
    enableWsi = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      # Esto hace autologin directo la primera vez o por defecto
      initial_session = {
        command = "gamescope --steam --prefer-output-res 1920x1080 --refresh 120 --adaptive-sync -- steam -gamepadui";
        user = "lisandro";
      };

      # Esta es la sesión de respaldo a la que se accede si cierras sesión o sales de Steam
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --asterisks --container-padding 3 --width 60 --window-padding 2 --time --battery --no-xsession-wrapper --cmd niri-session";
      };
    };
  };

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/

  systemd = {
    # To prevent getting stuck at shutdown
    settings = {
      Manager = {
        DefaultTimeoutStopSec = "10s";
      };
    };
    services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };

  system.stateVersion = "26.05";
}
