{ config, ... }:

let
  actions = config.lib.niri.actions;
in
{
  programs.niri.settings.binds = {
    # --- SISTEMA Y AYUDA ---
    "Mod+Shift+Slash" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "kenn/keybind-cheatsheet:cheatsheet"; hotkey-overlay.title = "Toggle Keybind Cheatsheet"; };
    "Ctrl+Alt+Delete" = { action = actions.quit; hotkey-overlay.title = "Quit Niri"; };

    # --- NOCTALIA INTERFACE ---
    "Mod+I" = { action = actions.spawn "noctalia" "msg" "settings-open"; hotkey-overlay.title = "Noctalia Settings"; };
    "Mod+Space" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "launcher"; hotkey-overlay.title = "Toggle App Launcher"; };
    "Mod+Ctrl+C" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "control-center"; hotkey-overlay.title = "Toggle Control Center"; };
    "Mod+Escape" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "session"; hotkey-overlay.title = "Toggle Power Session"; };
    "Mod+U" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "avivbintangaringga/nix-monitor:panel"; hotkey-overlay.title = "Toggle Nix Monitor"; };
    "Mod+W" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "wallpaper"; hotkey-overlay.title = "Toggle Wallpapers"; };
    "Mod+Shift+W" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "noctalia/wallhaven:browser"; hotkey-overlay.title = "Wallhaven Browser"; };
    "Mod+V" = { action = actions.spawn "noctalia" "msg" "panel-toggle" "clipboard"; hotkey-overlay.title = "Clipboard History"; };

    # --- NOTIFICACIONES, ENERGÍA Y UTILIDADES ---
    "Mod+Shift+V" = { action = actions.spawn "noctalia" "msg" "clipboard-clear"; hotkey-overlay.title = "Clear Clipboard"; };
    "Mod+Shift+N" = { action = actions.spawn "noctalia" "msg" "notification-clear-history"; hotkey-overlay.title = "Clear Notifications"; };
    "Mod+N" = { action = actions.spawn "noctalia" "msg" "notification-dnd-toggle"; hotkey-overlay.title = "Toggle Do Not Disturb"; };
    "Mod+P" = { action = actions.spawn "noctalia" "msg" "power-cycle"; hotkey-overlay.title = "Power Cycle"; };
    "Mod+C" = { action = actions.spawn "noctalia" "msg" "caffeine-toggle"; hotkey-overlay.title = "Toggle Caffeine"; };

    # --- APLICACIONES ---
    "Mod+Return" = { action = actions.spawn "ghostty"; hotkey-overlay.title = "Terminal (Ghostty)"; };
    "Mod+Shift+Return" = { action = actions.spawn "librewolf"; hotkey-overlay.title = "Browser (LibreWolf)"; };
    "Mod+B" = { action = actions.spawn "librewolf"; hotkey-overlay.title = "Browser (LibreWolf)"; };
    "Mod+Alt+B" = { action = actions.spawn "librewolf" "-p" "private"; hotkey-overlay.title = "Private Browser"; };
    "Mod+E" = { action = actions.spawn "nautilus"; hotkey-overlay.title = "File Manager"; };
    "Mod+Ctrl+A" = { action = actions.spawn "ghostty" "-e" "wiremix"; hotkey-overlay.title = "Audio Mixer (Wiremix)"; };
    "Mod+Ctrl+M" = { action = actions.spawn "ghostty" "-e" "cliamp" "${config.xdg.userDirs.music}"; hotkey-overlay.title = "Music Client"; };

    # --- GESTIÓN DE VENTANAS Y PANELES ---
    "Mod+Q" = { action = actions.close-window; hotkey-overlay.title = "Close Window"; };
    "Mod+T" = { action = actions.toggle-window-floating; hotkey-overlay.title = "Toggle Floating"; };
    "Mod+Shift+T" = { action = actions.switch-focus-between-floating-and-tiling; hotkey-overlay.title = "Focus Float/Tile"; };
    "Mod+Z" = { action = actions.toggle-column-tabbed-display; hotkey-overlay.title = "Toggle Tabbed Display"; };
    "Mod+O" = { action = actions.toggle-overview; hotkey-overlay.title = "Toggle Overview"; };

    # --- ANCHO DE COLUMNAS Y DIMENSIONES (PRESETS) ---
    "Mod+R" = { action = actions.switch-preset-column-width; hotkey-overlay.title = "Reset Column Width"; };
    "Mod+F" = { action = actions.maximize-column; hotkey-overlay.title = "Maximize Column"; };
    "Mod+Ctrl+F" = { action = actions.maximize-window-to-edges; hotkey-overlay.title = "Maximize Window Edges"; };
    "Mod+Alt+F" = { action = actions.fullscreen-window; hotkey-overlay.title = "Fullscreen Window"; };

    # --- CONSUMO Y EXPULSIÓN DE VENTANAS EN COLUMNAS ---
    "Mod+G" = { action = actions.consume-window-into-column; hotkey-overlay.title = "Consume Window into Column"; };
    "Mod+Alt+G" = { action = actions.expel-window-from-column; hotkey-overlay.title = "Expel Window from Column"; };
    "Mod+Comma" = { action = actions.consume-or-expel-window-left; hotkey-overlay.title = "Consume/Expel Left (<)"; };
    "Mod+Period" = { action = actions.consume-or-expel-window-right; hotkey-overlay.title = "Consume/Expel Right (>)"; };

    # --- NAVEGACIÓN DE FOCO (Vim HJKL) ---
    "Mod+H" = { action = actions.focus-column-left; hotkey-overlay.title = "Focus Left"; };
    "Mod+J" = { action = actions.focus-window-down; hotkey-overlay.title = "Focus Down"; };
    "Mod+K" = { action = actions.focus-window-up; hotkey-overlay.title = "Focus Up"; };
    "Mod+L" = { action = actions.focus-column-right; hotkey-overlay.title = "Focus Right"; };

    "Mod+Home" = { action = actions.focus-column-first; hotkey-overlay.title = "Focus First Column"; };
    "Mod+End" = { action = actions.focus-column-last; hotkey-overlay.title = "Focus Last Column"; };

    # --- MOVER VENTANAS / COLUMNAS ---
    "Mod+Shift+H" = { action = actions.move-column-left; hotkey-overlay.title = "Move Column Left"; };
    "Mod+Shift+J" = { action = actions.move-window-down; hotkey-overlay.title = "Move Window Down"; };
    "Mod+Shift+K" = { action = actions.move-window-up; hotkey-overlay.title = "Move Window Up"; };
    "Mod+Shift+L" = { action = actions.move-column-right; hotkey-overlay.title = "Move Column Right"; };

    "Mod+Shift+Home" = { action = actions.move-column-to-first; hotkey-overlay.title = "Move to First Column"; };
    "Mod+Shift+End" = { action = actions.move-column-to-last; hotkey-overlay.title = "Move to Last Column"; };

    # --- NAVEGACIÓN Y FOCO DE MONITORES ---
    "Mod+Alt+H" = { action = actions.focus-monitor-left; hotkey-overlay.title = "Focus Monitor Left"; };
    "Mod+Alt+J" = { action = actions.focus-monitor-down; hotkey-overlay.title = "Focus Monitor Down"; };
    "Mod+Alt+K" = { action = actions.focus-monitor-up; hotkey-overlay.title = "Focus Monitor Up"; };
    "Mod+Alt+L" = { action = actions.focus-monitor-right; hotkey-overlay.title = "Focus Monitor Right"; };

    "Mod+Shift+Alt+H" = { action = actions.move-workspace-to-monitor-left; hotkey-overlay.title = "Move Workspace to Monitor Left"; };
    "Mod+Shift+Alt+J" = { action = actions.move-workspace-to-monitor-down; hotkey-overlay.title = "Move Workspace to Monitor Down"; };
    "Mod+Shift+Alt+K" = { action = actions.move-workspace-to-monitor-up; hotkey-overlay.title = "Move Workspace to Monitor Up"; };
    "Mod+Shift+Alt+L" = { action = actions.move-workspace-to-monitor-right; hotkey-overlay.title = "Move Workspace to Monitor Right"; };

    # --- ESPACIOS DE TRABAJO Y PESTAÑAS ---
    "Mod+1" = { action = actions.focus-workspace 1; hotkey-overlay.title = "Focus Workspace 1"; };
    "Mod+2" = { action = actions.focus-workspace 2; hotkey-overlay.title = "Focus Workspace 2"; };
    "Mod+3" = { action = actions.focus-workspace 3; hotkey-overlay.title = "Focus Workspace 3"; };
    "Mod+4" = { action = actions.focus-workspace 4; hotkey-overlay.title = "Focus Workspace 4"; };
    "Mod+5" = { action = actions.focus-workspace 5; hotkey-overlay.title = "Focus Workspace 5"; };
    "Mod+6" = { action = actions.focus-workspace 6; hotkey-overlay.title = "Focus Workspace 6"; };
    "Mod+7" = { action = actions.focus-workspace 7; hotkey-overlay.title = "Focus Workspace 7"; };
    "Mod+8" = { action = actions.focus-workspace 8; hotkey-overlay.title = "Focus Workspace 8"; };
    "Mod+9" = { action = actions.focus-workspace 9; hotkey-overlay.title = "Focus Workspace 9"; };

    "Mod+Tab" = { action = actions.focus-workspace-up; hotkey-overlay.title = "Focus Workspace Up"; };
    "Mod+Shift+Tab" = { action = actions.focus-workspace-down; hotkey-overlay.title = "Focus Workspace Down"; };

    "Mod+Shift+1" = { action.move-column-to-workspace = 1; hotkey-overlay.title = "Move Column to Workspace 1"; };
    "Mod+Shift+2" = { action.move-column-to-workspace = 2; hotkey-overlay.title = "Move Column to Workspace 2"; };
    "Mod+Shift+3" = { action.move-column-to-workspace = 3; hotkey-overlay.title = "Move Column to Workspace 3"; };
    "Mod+Shift+4" = { action.move-column-to-workspace = 4; hotkey-overlay.title = "Move Column to Workspace 4"; };
    "Mod+Shift+5" = { action.move-column-to-workspace = 5; hotkey-overlay.title = "Move Column to Workspace 5"; };

    "Mod+Page_Up" = { action = actions.move-column-to-workspace-up; hotkey-overlay.title = "Move Workspace Up"; };
    "Mod+Page_Down" = { action = actions.move-column-to-workspace-down; hotkey-overlay.title = "Move Workspace Down"; };

    # --- REDIMENSIONADO DE VENTANAS ---
    "Mod+Ctrl+H" = { action = actions.set-column-width "-10%"; hotkey-overlay.title = "Shrink Column Width"; };
    "Mod+Ctrl+L" = { action = actions.set-column-width "+10%"; hotkey-overlay.title = "Grow Column Width"; };
    "Mod+Ctrl+J" = { action = actions.set-window-height "+10%"; hotkey-overlay.title = "Grow Window Height"; };
    "Mod+Ctrl+K" = { action = actions.set-window-height "-10%"; hotkey-overlay.title = "Shrink Window Height"; };

    # --- MULTIMEDIA (INTEGRACIÓN IPC NOCTALIA) ---
    "XF86AudioRaiseVolume"    = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "volume-up"; hotkey-overlay.title = "Volume Up"; };
    "XF86AudioLowerVolume"    = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "volume-down"; hotkey-overlay.title = "Volume Down"; };
    "XF86AudioMute"           = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "volume-mute"; hotkey-overlay.title = "Volume Mute"; };
    "XF86AudioMicMute"        = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "mic-mute"; hotkey-overlay.title = "Mic Mute"; };
    "XF86MonBrightnessUp"     = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "brightness-up"; hotkey-overlay.title = "Brightness Up"; };
    "XF86MonBrightnessDown"   = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "brightness-down"; hotkey-overlay.title = "Brightness Down"; };
    "XF86AudioPlay"           = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "toggle"; hotkey-overlay.title = "Media Toggle Play/Pause"; };
    "XF86AudioPause"          = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "toggle"; hotkey-overlay.title = "Media Toggle Play/Pause"; };
    "XF86AudioNext"           = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "next"; hotkey-overlay.title = "Media Next Track"; };
    "XF86AudioPrev"           = { allow-when-locked = true; action = actions.spawn "noctalia" "msg" "media" "previous"; hotkey-overlay.title = "Media Previous Track"; };

    # --- CAPTURAS Y ANOTACIÓN ---
    "Mod+Shift+S" = { action = actions.spawn "noctalia" "msg" "screenshot-annotate"; hotkey-overlay.title = "Screenshot Annotate"; };
    "Print" = { action = actions.spawn "noctalia" "msg" "screenshot-region"; hotkey-overlay.title = "Screenshot Region"; };
    "Ctrl+Print" = { action = actions.spawn "noctalia" "msg" "screenshot-fullscreen" "pick"; hotkey-overlay.title = "Fullscreen Screenshot (Pick)"; };
    "Shift+Print" = { action = actions.spawn "noctalia" "msg" "screenshot-fullscreen" "all"; hotkey-overlay.title = "Fullscreen Screenshot (All)"; };
  };
}
