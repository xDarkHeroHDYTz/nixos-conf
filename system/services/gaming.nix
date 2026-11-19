{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      gamemode
      pkgsi686Linux.gamemode
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
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
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
        ioprio = 0;
        inhibit_screensaver = 1;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };
}
