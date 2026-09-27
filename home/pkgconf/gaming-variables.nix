{ pkgs, ... }:


{
  home.packages = [
    (pkgs.writeShellScriptBin "run-game" ''
      # --- OVERLAYS & MONITORIZACIÓN ---
      export MANGOHUD=1

      # --- PROTON & NVAPI (NVIDIA) ---
      # export WAYLANDDRV_PRIMARY_MONITOR=(Salida) # Si se abre en otro monitor
      # export PROTON_DXVK_LOWLATENCY=1 # Si no tiene Reflex nativo
      # export PROTON_DLSS_UPGRADE=1
      export PROTON_ENABLE_NVAPI=1
      export DXVK_NVAPI_VKREFLEX=1
      export PROTON_ENABLE_NTSYNC=1

      # --- NVIDIA SHADER CACHE (10 GB sin borrado agresivo) ---
      export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
      export __GL_SHADER_DISK_CACHE_SIZE=10737418240

      # --- EJECUCIÓN CON GAMEMODE ---
      if command -v gamemoderun &> /dev/null; then
        exec gamemoderun "$@"
      else
        exec "$@"
      fi
    '')

    (pkgs.writeShellScriptBin "run-native" ''
      # --- OVERLAYS ---
      export MANGOHUD=1

      # --- WAYLAND NATIVO PARA TOOLKITS ---
      export SDL_VIDEODRIVER="wayland,x11"
      export QT_QPA_PLATFORM="wayland;xcb"
      export GDK_BACKEND="wayland,x11"

      # --- SHADER CACHE (10 GB) ---
      export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
      export __GL_SHADER_DISK_CACHE_SIZE=10737418240

      # --- EJECUCIÓN CON GAMEMODE ---
      if command -v gamemoderun &> /dev/null; then
        exec gamemoderun "$@"
      else
        exec "$@"
      fi
    '')
  ];
}
