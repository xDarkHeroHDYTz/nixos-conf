{ ... }:

{
  programs.niri.settings = {
    input = {
      mouse = {
        accel-speed = -0.6;
        accel-profile = "flat";
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
        accel-speed = 0.1;
        accel-profile = "adaptive";
        click-method = "button-areas";
      };
      focus-follows-mouse = {
        enable = true;
      };
      warp-mouse-to-focus = {
        enable = true;
      };
    };

    cursor = {
      theme = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
