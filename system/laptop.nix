{ ... }:

{
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

  # --- INTEL UNDERVOLT (Reduce temperaturas del i7-8750H) ---
  services.undervolt = {
    enable = true;
    coreOffset = -165;
    gpuOffset = -65;
    uncoreOffset = -65;
    temp = 90;
  };

  # --- GESTIÓN DE ENERGÍA INTELIGENTE (AC vs BATERÍA) ---
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      START_CHARGE_THRESH_AC = 90;
      STOP_CHARGE_THRESH_AC = 95;
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  services.upower.enable = true; # Batería
  #services.libinput.enable = true; # Touchpad
}
