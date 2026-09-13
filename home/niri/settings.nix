{  pkgs, ... }:

{
  imports = [
    ./inputs.nix
    ./keybindings.nix
    ./startup.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      # --- ESTÉTICA, REGLAS Y ANIMACIONES ---
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
          opacity = 0.90;
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
          matches = [ { app-id = "(?i)^steam$"; title = "^$"; } ];
          open-floating = true;
          open-focused = false;
        }
        {
          matches = [ { app-id = "(?i)^steam$"; title = "(?i)^notificationtoasts"; } ];
          open-floating = true;
          open-focused = false;
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
            from = "#ffffffa0";
            to = "#ffffff20";
            angle = 45;
            relative-to = "workspace-view";
          };
          inactive.color = "#20202050";
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
          damping-ratio = 1.0;
          stiffness = 1300;
          epsilon = 0.0001;
        };

        window-open.kind.easing = {
          duration-ms = 120;
          curve = "ease-out-expo";
        };

        window-close.kind.easing = {
          duration-ms = 90;
          curve = "ease-out-quad";
        };

        horizontal-view-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1100;
          epsilon = 0.0001;
        };

        window-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1200;
          epsilon = 0.0001;
        };

        window-resize.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1200;
          epsilon = 0.0001;
        };

        overview-open-close.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1100;
          epsilon = 0.0001;
        };
      };
    };
  };
}
