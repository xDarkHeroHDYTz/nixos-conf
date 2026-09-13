{ config, ... }:

let
  actions = config.lib.niri.actions;
in
{
  programs.niri.settings.binds = {
    # --- SISTEMA Y AYUDA ---
    "Mod+Shift+Slash".action = actions.show-hotkey-overlay;
    "Ctrl+Alt+Delete".action = actions.quit;

    # --- NOCTALIA INTERFACE ---
    "Mod+Space".action = actions.spawn "noctalia" "msg" "panel-toggle" "launcher";
    "Mod+Ctrl+Space".action = actions.spawn "noctalia" "msg" "panel-open" "control-center";
    "Mod+Ctrl+I".action = actions.spawn "noctalia" "msg" "settings-open";
    "Mod+Alt+Space".action = actions.spawn "noctalia" "msg" "panel-open" "session";

    # --- APLICACIONES ---
    "Mod+Return".action = actions.spawn "ghostty";
    "Mod+Shift+Return".action = actions.spawn "librewolf";
    "Mod+Shift+B".action = actions.spawn "librewolf";
    "Mod+Shift+Alt+B".action = actions.spawn "librewolf" "-p" "private";
    "Mod+Shift+F".action = actions.spawn "nautilus";
    "Mod+Ctrl+A".action = actions.spawn "ghostty" "-e" "wiremix";
    "Mod+Ctrl+M".action = actions.spawn "ghostty" "-e" "cliamp" "${config.xdg.userDirs.music}";

    # --- GESTIÓN DE VENTANAS ---
    "Mod+W".action = actions.close-window;
    "Mod+T".action = actions.toggle-window-floating;
    "Mod+Shift+T".action = actions.switch-focus-between-floating-and-tiling;
    "Mod+J".action = actions.toggle-column-tabbed-display;
    "Mod+O".action = actions.toggle-overview;

    # --- ANCHO DE COLUMNAS Y DIMENSIONES (PRESETS) ---
    "Mod+R".action = actions.switch-preset-column-width;
    "Mod+F".action = actions.maximize-column;
    "Mod+Ctrl+F".action = actions.maximize-window-to-edges;
    "Mod+Alt+F".action = actions.fullscreen-window;

    # --- CONSUMO Y EXPULSIÓN DE VENTANAS EN COLUMNAS ---
    "Mod+G".action = actions.consume-window-into-column;
    "Mod+Alt+G".action = actions.expel-window-from-column;
    "Mod+BracketLeft".action = actions.consume-or-expel-window-left;
    "Mod+BracketRight".action = actions.consume-or-expel-window-right;

    # --- ESPACIOS DE TRABAJO (WORKSPACES) ---
    "Mod+1".action = actions.focus-workspace 1;
    "Mod+2".action = actions.focus-workspace 2;
    "Mod+3".action = actions.focus-workspace 3;
    "Mod+4".action = actions.focus-workspace 4;
    "Mod+5".action = actions.focus-workspace 5;
    "Mod+6".action = actions.focus-workspace 6;
    "Mod+7".action = actions.focus-workspace 7;
    "Mod+8".action = actions.focus-workspace 8;
    "Mod+9".action = actions.focus-workspace 9;

    "Mod+Tab".action = actions.focus-workspace-down;
    "Mod+Shift+Tab".action = actions.focus-workspace-up;

    # Movimiento a workspaces numéricos
    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;

    "Mod+Page_Down".action = actions.move-column-to-workspace-down;
    "Mod+Page_Up".action = actions.move-column-to-workspace-up;
    "Mod+Shift+Page_Down".action = actions.move-column-to-workspace-down;
    "Mod+Shift+Page_Up".action = actions.move-column-to-workspace-up;

    "Mod+Shift+Alt+Up".action = actions.move-workspace-to-monitor-up;
    "Mod+Shift+Alt+Down".action = actions.move-workspace-to-monitor-down;
    "Mod+Shift+Alt+Right".action = actions.move-workspace-to-monitor-right;
    "Mod+Shift+Alt+Left".action = actions.move-workspace-to-monitor-left;

    # --- NAVEGACIÓN Y MOVIMIENTO DE FOCO ---
    "Mod+Left".action = actions.focus-column-left;
    "Mod+Down".action = actions.focus-window-down;
    "Mod+Up".action = actions.focus-window-up;
    "Mod+Right".action = actions.focus-column-right;

    "Mod+Alt+Up".action = actions.focus-monitor-up;
    "Mod+Alt+Down".action = actions.focus-monitor-down;
    "Mod+Alt+Right".action = actions.focus-monitor-right;
    "Mod+Alt+Left".action = actions.focus-monitor-left;

    "Mod+Shift+Left".action = actions.move-column-left;
    "Mod+Shift+Down".action = actions.move-window-down;
    "Mod+Shift+Up".action = actions.move-window-up;
    "Mod+Shift+Right".action = actions.move-column-right;

    "Alt+Tab".action = actions.focus-column-right;
    "Alt+Shift+Tab".action = actions.focus-column-left;

    # --- REDIMENSIONADO ---
    "Mod+Ctrl+Left".action = actions.set-column-width "-10%";
    "Mod+Ctrl+Right".action = actions.set-column-width "+10%";
    "Mod+Ctrl+Down".action = actions.set-window-height "+10%";
    "Mod+Ctrl+Up".action = actions.set-window-height "-10%";

    # --- MULTIMEDIA (INTEGRACIÓN IPC NOCTALIA) ---
    "XF86AudioRaiseVolume" = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "volume-up"; };
    "XF86AudioLowerVolume" = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "volume-down"; };
    "XF86AudioMute"        = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "volume-mute"; };
    "XF86AudioMicMute"     = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "mic-mute"; };
    "XF86MonBrightnessUp"  = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "brightness-up"; };
    "XF86MonBrightnessDown"= { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "brightness-down"; };
    "XF86AudioPlay"        = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "toggle"; };
    "XF86AudioPause"       = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "toggle"; };
    "XF86AudioNext"        = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "next"; };
    "XF86AudioPrev"        = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "previous"; };

    "Print".action = actions.spawn "noctalia" "msg" "screenshot-region";
    "Ctrl+Print".action = actions.spawn "noctalia" "msg" "screenshot-fullscreen" "monitor";
    "Alt+Print".action = actions.spawn "noctalia" "msg" "screenshot-fullscreen" "pick";
  };
}
