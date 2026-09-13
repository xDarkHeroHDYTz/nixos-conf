{ ... }:

{
  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "dbus-update-activation-environment" "--systemd" "DISPLAY" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" ]; }
      { command = [ "xwayland-satellite" ]; }
    ];

    hotkey-overlay = {
      skip-at-startup = true;
    };
  };
}
