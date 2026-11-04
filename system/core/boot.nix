{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    loader.efi.canTouchEfiVariables = true;
    plymouth = {
      enable = true;
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "mem_sleep_default=deep"
    ];

    kernel.sysctl = {
      "fs.protected_regular" = 2;
      "fs.protected_fifos" = 2;
      "kernel.kptr_restrict" = 2;
      "kernel.sysrq" = 176;
    };
  };
}
