{ ... }:

{
  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
    ];

    hotkey-overlay = {
      skip-at-startup = true;
    };
  };
}
