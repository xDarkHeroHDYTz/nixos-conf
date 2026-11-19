{ config, pkgs, ... }:

{
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_EnableGpuFirmware=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  programs.gamemode.settings.gpu.nv_powermizer_mode = 1; # Fuerza "Prefer Maximum Performance" en la RTX 4070 solo al jugar
}
