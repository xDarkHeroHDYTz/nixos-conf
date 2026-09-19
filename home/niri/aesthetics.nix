{ config, ... }:

{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [ { namespace = "^noctalia-backdrop"; } ];
        place-within-backdrop = true;
      }
    ];

    overview = {
      workspace-shadow = {
        enable = false;
      };
    };

    debug.honor-xdg-activation-with-invalid-serial = true;

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ { is-active = false; } ];
        opacity = 0.96;
      }
      {
        matches = [ { app-id = "^mpv$"; } ];
        variable-refresh-rate = true;
      }
      {
        matches = [ { app-id = "(?i)^(steam_app_.*|cs2|hoi4|efootball.exe)$"; } ];
        variable-refresh-rate = true;
      }
      {
        matches = [ { app-id = "(?i)^steam$"; title = "(?i)^notificationtoasts"; } ];
        open-floating = true;
        open-focused = false;
        default-floating-position = {
          x = 24;
          y = 24;
          relative-to = "top-right";
        };
      }
    ];

    layout = {
      default-column-width = { proportion = 0.5; };
      background-color = "transparent";
      shadow.enable = true;

      focus-ring = {
        enable = true;
        width = 2;
        active.gradient = {
          from = "${config.lib.stylix.colors.withHashtag.base0D}a0";
          to = "${config.lib.stylix.colors.withHashtag.base0E}20";
          angle = 45;
          relative-to = "workspace-view";
        };
        inactive.color = "${config.lib.stylix.colors.withHashtag.base01}50";
      };

      border = {
        enable = false;
        width = 0;
      };
    };

    prefer-no-csd = true;

    animations = {
      slowdown = 1.0;

      workspace-switch.kind.spring = {
        damping-ratio = 0.82;
        stiffness = 1000;
        epsilon = 0.0001;
      };

      window-open.kind.easing = {
        duration-ms = 140;
        curve = "ease-out-expo";
      };

      window-close.kind.easing = {
        duration-ms = 90;
        curve = "ease-out-quad";
      };

      horizontal-view-movement.kind.spring = {
        damping-ratio = 0.85;
        stiffness = 950;
        epsilon = 0.0001;
      };

      window-movement.kind.spring = {
        damping-ratio = 0.80;
        stiffness = 1100;
        epsilon = 0.0001;
      };

      window-resize.kind.spring = {
        damping-ratio = 0.85;
        stiffness = 1000;
        epsilon = 0.0001;
      };

      overview-open-close.kind.spring = {
        damping-ratio = 0.78;
        stiffness = 900;
        epsilon = 0.0001;
      };
    };
  };
}
