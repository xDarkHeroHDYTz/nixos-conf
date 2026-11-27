{ pkgs, ... }:

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
        layout = "latam";
        # variant = "";
      };

      outputs = {
        "eDP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 144.028;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
      };
    };
  };
}
