{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "run-game" ''
      # --- OVERLAYS & MONITORIZACIÓN ---
      export MANGOHUD=1

      # --- PROTON, NVAPI & UPSCALERS ---
      # export PROTON_LOG=1
      export PROTON_ENABLE_WAYLAND=1
      export PROTON_ENABLE_NVAPI=1
      export PROTON_HIDE_NVIDIA_GPU=0
      export DXVK_NVAPI_VKREFLEX=1
      export PROTON_ENABLE_NGX_UPDATES=1
      export PROTON_DLSS_UPGRADE=1
      export PROTON_DXVK_LOWLATENCY=1
      export VKD3D_CONFIG=dxr11,dxr

      # --- RENDERING & LOW LATENCY (NVIDIA) ---
      export LOW_LATENCY_LAYER=1
      export LOW_LATENCY_LAYER_REFLEX=1
      export __GL_SYNC_TO_VBLANK=0
      export __GL_THREADED_OPTIMIZATION=1
      export __GL_MaxFramesAllowed=1
      export __GL_VRR_ALLOWED=1
      export __GL_GSYNC_ALLOWED=1
      export __GLX_VENDOR_LIBRARY_NAME=nvidia

      # --- SHADER CACHE (10 GB) ---
      export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
      export __GL_SHADER_DISK_CACHE_SIZE=10240

      # --- EJECUCIÓN CON GAMEMODE ---
      if command -v gamemoderun &> /dev/null; then
        exec gamemoderun "$@"
      else
        exec "$@"
      fi
    '')

    (pkgs.writeShellScriptBin "run-native" ''
      # --- OVERLAYS & MONITORIZACIÓN ---
      export MANGOHUD=1

      # --- TOOLKITS & WAYLAND NATIVO ---
      export SDL_VIDEODRIVER="wayland,x11"
      export QT_QPA_PLATFORM="wayland;xcb"
      export CLUTTER_BACKEND="wayland"

      # --- RENDERING & LOW LATENCY (NVIDIA) ---
      export LOW_LATENCY_LAYER=1
      export LOW_LATENCY_LAYER_REFLEX=1
      export __GL_SYNC_TO_VBLANK=0
      export __GL_THREADED_OPTIMIZATION=1
      export __GL_MaxFramesAllowed=1
      export __GL_VRR_ALLOWED=1
      export __GL_GSYNC_ALLOWED=1
      export __GLX_VENDOR_LIBRARY_NAME=nvidia

      # --- SHADER CACHE (10 GB) ---
      export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
      export __GL_SHADER_DISK_CACHE_SIZE=10240

      # --- EJECUCIÓN CON GAMEMODE ---
      if command -v gamemoderun &> /dev/null; then
        exec gamemoderun "$@"
      else
        exec "$@"
      fi
    '')
  ];
}
