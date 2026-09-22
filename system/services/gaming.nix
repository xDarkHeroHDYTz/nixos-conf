{ inputs, pkgs, ... }:

{
  imports = [
    inputs.low-latency-layer.nixosModules.low-latency-layer
  ];

  programs.low-latency-layer.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    localNetworkGameTransfers.openFirewall = false;
  };

  services.wivrn = {
    enable = true;
    package = pkgs.wivrn.override { cudaSupport = true; };
    openFirewall = true;
    steam = {
      enable = true;
      importOXRRuntimes = true;
    };
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
        renice = 10;
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
}
