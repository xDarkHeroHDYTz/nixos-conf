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

  programs.gamemode.enable = true;
}
