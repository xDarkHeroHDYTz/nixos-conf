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
    "Mod+I".action = actions.spawn "noctalia" "msg" "settings-open";
    "Mod+Space".action = actions.spawn "noctalia" "msg" "panel-toggle" "launcher";
    "Mod+Ctrl+C".action = actions.spawn "noctalia" "msg" "panel-toggle" "control-center";
    "Mod+Escape".action = actions.spawn "noctalia" "msg" "panel-toggle" "session";
    "Mod+U".action = actions.spawn "noctalia" "msg" "panel-toggle" "avivbintangaringga/nix-monitor:panel";
    "Mod+W".action = actions.spawn "noctalia" "msg" "panel-toggle" "wallpaper";
    "Mod+Shift+W".action = actions.spawn "noctalia" "msg" "panel-toggle" "noctalia/wallhaven:browser";
    "Mod+V".action = actions.spawn "noctalia" "msg" "panel-toggle" "clipboard";

    # --- NOTIFICACIONES, ENERGÍA Y UTILIDADES ---
    "Mod+Shift+V".action = actions.spawn "noctalia" "msg" "clipboard-clear";
    "Mod+Shift+N".action = actions.spawn "noctalia" "msg" "notification-clear-history";
    "Mod+N".action = actions.spawn "noctalia" "msg" "notification-dnd-toggle";
    "Mod+P".action = actions.spawn "noctalia" "msg" "power-cycle";
    "Mod+C".action = actions.spawn "noctalia" "msg" "caffeine-toggle";

    # --- APLICACIONES ---
    "Mod+Return".action = actions.spawn "ghostty";
    "Mod+Shift+Return".action = actions.spawn "librewolf";
    "Mod+B".action = actions.spawn "librewolf";
    "Mod+Alt+B".action = actions.spawn "librewolf" "-p" "private";
    "Mod+E".action = actions.spawn "nautilus";
    "Mod+Ctrl+A".action = actions.spawn "ghostty" "-e" "wiremix";
    "Mod+Ctrl+M".action = actions.spawn "ghostty" "-e" "cliamp" "${config.xdg.userDirs.music}";

    # --- GESTIÓN DE VENTANAS Y PANELES ---
    "Mod+Q".action = actions.close-window;
    "Mod+T".action = actions.toggle-window-floating;
    "Mod+Shift+T".action = actions.switch-focus-between-floating-and-tiling;
    "Mod+Z".action = actions.toggle-column-tabbed-display;
    "Mod+O".action = actions.toggle-overview;

    # --- ANCHO DE COLUMNAS Y DIMENSIONES (PRESETS) ---
    "Mod+R".action = actions.switch-preset-column-width;
    "Mod+F".action = actions.maximize-column;
    "Mod+Ctrl+F".action = actions.maximize-window-to-edges;
    "Mod+Alt+F".action = actions.fullscreen-window;

    # --- CONSUMO Y EXPULSIÓN DE VENTANAS EN COLUMNAS ---
    "Mod+G".action = actions.consume-window-into-column;
    "Mod+Alt+G".action = actions.expel-window-from-column;
    "Mod+Comma".action = actions.consume-or-expel-window-left;
    "Mod+Period".action = actions.consume-or-expel-window-right;

    # --- NAVEGACIÓN DE FOCO ---
    "Mod+H".action = actions.focus-column-left;
    "Mod+J".action = actions.focus-window-down;
    "Mod+K".action = actions.focus-window-up;
    "Mod+L".action = actions.focus-column-right;

    "Mod+Home".action = actions.focus-column-first;
    "Mod+End".action = actions.focus-column-last;

    # --- MOVER VENTANAS / COLUMNAS ---
    "Mod+Shift+H".action = actions.move-column-left;
    "Mod+Shift+J".action = actions.move-window-down;
    "Mod+Shift+K".action = actions.move-window-up;
    "Mod+Shift+L".action = actions.move-column-right;

    "Mod+Shift+Home".action = actions.move-column-to-first;
    "Mod+Shift+End".action = actions.move-column-to-last;

    # --- NAVEGACIÓN Y FOCO DE MONITORES ---
    "Mod+Alt+H".action = actions.focus-monitor-left;
    "Mod+Alt+J".action = actions.focus-monitor-down;
    "Mod+Alt+K".action = actions.focus-monitor-up;
    "Mod+Alt+L".action = actions.focus-monitor-right;

    "Mod+Shift+Alt+H".action = actions.move-workspace-to-monitor-left;
    "Mod+Shift+Alt+J".action = actions.move-workspace-to-monitor-down;
    "Mod+Shift+Alt+K".action = actions.move-workspace-to-monitor-up;
    "Mod+Shift+Alt+L".action = actions.move-workspace-to-monitor-right;

    # --- ESPACIOS DE TRABAJO Y PESTAÑAS ---
    "Mod+1".action = actions.focus-workspace 1;
    "Mod+2".action = actions.focus-workspace 2;
    "Mod+3".action = actions.focus-workspace 3;
    "Mod+4".action = actions.focus-workspace 4;
    "Mod+5".action = actions.focus-workspace 5;
    "Mod+6".action = actions.focus-workspace 6;
    "Mod+7".action = actions.focus-workspace 7;
    "Mod+8".action = actions.focus-workspace 8;
    "Mod+9".action = actions.focus-workspace 9;

    "Mod+Tab".action = actions.focus-workspace-up;
    "Mod+Shift+Tab".action = actions.focus-workspace-down;

    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;

    "Mod+Page_Up".action = actions.move-column-to-workspace-up;
    "Mod+Page_Down".action = actions.move-column-to-workspace-down;

    # --- REDIMENSIONADO DE VENTANAS ---
    "Mod+Ctrl+H".action = actions.set-column-width "-10%";
    "Mod+Ctrl+L".action = actions.set-column-width "+10%";
    "Mod+Ctrl+J".action = actions.set-window-height "+10%";
    "Mod+Ctrl+K".action = actions.set-window-height "-10%";

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

    "Mod+Shift+S".action = actions.spawn "noctalia" "msg" "screenshot-annotate";
    "Print".action = actions.spawn "noctalia" "msg" "screenshot-region";
    "Ctrl+Print".action = actions.spawn "noctalia" "msg" "screenshot-fullscreen" "pick";
    "Shift+Print".action = actions.spawn "noctalia" "msg" "screenshot-fullscreen" "all";
  };
}
