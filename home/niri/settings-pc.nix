{  pkgs, ... }:

{
  imports = [
    ./aesthetics.nix
    ./inputs.nix
    ./keybindings.nix
    ./startup.nix
  ];

  programs.niri = {
    package = pkgs.niri;
    settings = {
      input.keyboard.xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
      outputs = {
        "PNP(AOC) Q27G3XMN 1APQ7JA003333" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 180.002;
          };
          position = { x = 0; y = 0; };
          variable-refresh-rate = "on-demand";
        };

        "LG Electronics LG ULTRAGEAR+ 509RMRHKG358" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 280.099;
          };
          position = { x = 0; y = 1440; };
          variable-refresh-rate = "on-demand";
          focus-at-startup = true;
        };

        "Nvidia 0x0000 Unknown" = {
          enable = false;
        };
      };
    };
  };
}
