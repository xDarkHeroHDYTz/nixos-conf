{ ... }:

{
  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
      { command = [ "noctalia" ]; }
    ];

    hotkey-overlay = {
      skip-at-startup = true;
    };
  };
}
