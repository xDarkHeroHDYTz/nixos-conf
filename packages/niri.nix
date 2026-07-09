{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    // Configuración Niri: Noctalia Shell + Layout Ergonómico Omarchy

    input {
        keyboard {
            xkb {
                layout "us"
                variant "altgr-intl"
            }
        }
        mouse {
            accel-speed -0.6
            accel-profile "flat"
        }
        focus-follows-mouse
        warp-mouse-to-focus
    }

    output "DP-3" {
        mode "2560x1440@180.002"
        position x=0 y=0
        variable-refresh-rate on-demand=true
    }
    output "DP-2" {
        mode "2560x1440@280.099"
        position x=0 y=1440
        variable-refresh-rate on-demand=true
        focus-at-startup
    }

    // --- ENTORNO Y ARRANQUE DE COMPONENTES ---
    spawn-sh-at-startup "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri NIXOS_OZONE_HWACCEL"
    spawn-sh-at-startup "systemctl --user stop xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk; systemctl --user start xdg-desktop-portal"
    spawn-at-startup "systemctl" "--user" "start" "niri-session.target"
    spawn-at-startup "xwayland-satellite"
    spawn-sh-at-startup "sleep 1 && (noctalia || noctalia-shell || qs -c noctalia-shell)"
    spawn-at-startup "openrgb" "-p" "Red-Low"

    hotkey-overlay {
        skip-at-startup
    }

    // =====================================================================
    // --- AESTHETICS ---
    // =====================================================================
    window-rule {
        opacity 0.90
        geometry-corner-radius 12
        clip-to-geometry true
    }
    layout {
        default-column-width { proportion 0.5; }
        shadow {
            on
        }
        focus-ring {
            off
            width 0
        }
        border {
            off
            width 0
        }
    }
    prefer-no-csd

    binds {
            // =====================================================================
            // --- ATAJOS DE SISTEMA BÁSICOS ---
            // =====================================================================
            Mod+Space { spawn "noctalia" "msg" "panel-toggle" "launcher"; }
            Mod+Ctrl+Space { spawn "noctalia" "msg" "panel-open" "control-center"; }
            Mod+Alt+Space { spawn "noctalia" "msg" "panel-open" "session"; }

            Mod+Return { spawn "alacritty"; }          // Supr + Enter abre Alacritty
            Mod+Shift+Return { spawn "librewolf"; }    // Supr + Shift + Enter abre LibreWolf
            Mod+Shift+B { spawn "librewolf"; }    // Supr + Shift + B abre LibreWolf
            Mod+Shift+Alt+B { spawn "librewolf" "-p" "privacy"; }    // Supr + Shift + Alt+ B abre LibreWolf modo privado
            Mod+Shift+F { spawn "nautilus"; }          // Supr + Shift + F abre Files
            Mod+Ctrl+A { spawn "alacritty" "-e" "wiremix"; }
            Mod+Ctrl+M { spawn "alacritty" "-e" "cliamp" "/home/lisandro/Music/"; }

            Mod+W { close-window; } // Close window
            Ctrl+Alt+Delete { quit; } // Close all windows / Quit Niri

            Mod+T { toggle-window-floating; } // Toggle window between tiling/floating
            Mod+J { toggle-column-tabbed-display; } // Toggle window position (Niri: pestaña/mosaico en columna)
            Mod+O { toggle-overview; } // Toggle overview / layout view

            // --- PANTALLA COMPLETA Y DIMENSIONES ---
            Mod+F       { maximize-column; } // Go full width
            Mod+Ctrl+F  { maximize-window-to-edges; } // Go full screen inside window
            Mod+Alt+F   { fullscreen-window; } // Go full screen

            // =====================================================================
            // --- ESPACIOS DE TRABAJO (WORKSPACES) ---
            // =====================================================================
            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }
            Mod+6 { focus-workspace 6; }
            Mod+7 { focus-workspace 7; }
            Mod+8 { focus-workspace 8; }
            Mod+9 { focus-workspace 9; }

            Mod+Tab       { focus-workspace-down; } // Jump to next workspace
            Mod+Shift+Tab { focus-workspace-up; }   // Jump to previous workspace

            Mod+Shift+1 { move-column-to-workspace 1; } // Move window to workspace
            Mod+Shift+2 { move-column-to-workspace 2; }
            Mod+Shift+3 { move-column-to-workspace 3; }
            Mod+Shift+4 { move-column-to-workspace 4; }
            Mod+Shift+5 { move-column-to-workspace 5; }

            // Move workspaces to directional monitor
            Mod+Shift+Alt+Up    { move-workspace-to-monitor-up; }
            Mod+Shift+Alt+Down  { move-workspace-to-monitor-down; }
            Mod+Shift+Alt+Right { move-workspace-to-monitor-right; }
            Mod+Shift+Alt+Left  { move-workspace-to-monitor-left; }

            // =====================================================================
            // --- NAVEGACIÓN Y MOVIMIENTO (CORE OMARCHY EN NIRI) ---
            // =====================================================================
            // Move focus to window in direction of arrow
            Mod+Left  { focus-column-left; }
            Mod+Down  { focus-window-down; }
            Mod+Up    { focus-window-up; }
            Mod+Right { focus-column-right; }

            Mod+Alt+Up   { focus-monitor-up; }
            Mod+Alt+Down { focus-monitor-down; }
            Mod+Alt+Right { focus-monitor-right; }
            Mod+Alt+Left { focus-monitor-left; }

            // Swap window with another in direction of arrow
            Mod+Shift+Left  { move-column-left; }
            Mod+Shift+Down  { move-window-down; }
            Mod+Shift+Up    { move-window-up; }
            Mod+Shift+Right { move-column-right; }

            // =====================================================================
            // --- REDIMENSIONADO DE VENTANAS (GROW WINDOWS) ---
            // =====================================================================
            Mod+Ctrl+Left  { set-column-width "-10%"; }
            Mod+Ctrl+Right { set-column-width "+10%"; }
            Mod+Ctrl+Down  { set-window-height "+10%"; }
            Mod+Ctrl+Up    { set-window-height "-10%"; }

            // =====================================================================
            // --- GESTIÓN DE GRUPOS (ANIDACIÓN DE COLUMNAS EN NIRI) ---
            // =====================================================================
            Mod+G     { consume-window-into-column; } // Toggle window grouping
            Mod+Alt+G { expel-window-from-column; } // Move window out of grouping

            // Cycle forward/backward through windows on active workspace
            Alt+Tab       { focus-column-right; }
            Alt+Shift+Tab { focus-column-left; }

            // =====================================================================
            // --- MULTIMEDIA (INTEGRACIÓN IPC NOCTALIA) ---
            // =====================================================================
            XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" "-l" "1.0"; }
            XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
            XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SINK@" "toggle"; }
            XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
            XF86MonBrightnessUp   allow-when-locked=true { spawn "noctalia" "msg" "brightness-up"; }
            XF86MonBrightnessDown allow-when-locked=true { spawn "noctalia" "msg" "brightness-down"; }
            XF86AudioPlay  allow-when-locked=true { spawn "noctalia" "msg" "media" "toggle"; }
            XF86AudioPause allow-when-locked=true { spawn "noctalia" "msg" "media" "toggle"; }
            XF86AudioNext  allow-when-locked=true { spawn "noctalia" "msg" "media" "next"; }
            XF86AudioPrev  allow-when-locked=true { spawn "noctalia" "msg" "media" "previous"; }

            Print      { spawn "noctalia" "msg" "screenshot-region"; }
            Ctrl+Print { spawn "noctalia" "msg" "screenshot-fullscreen" "monitor"; }
            Alt+Print  { screenshot-window; }
        }
  '';
}
