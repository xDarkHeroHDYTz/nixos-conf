{ ... }:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      # GPU
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      gpu_power = true;
      gpu_load_change = true;

      # CPU
      cpu_stats = true;
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;

      # Memoria y FPS
      vram = true;
      ram = true;
      fps = true;
      frametime = true;

      # Información del Sistema
      vulkan_driver = true;
      architecture = true;
      resolution = true;

      # Apariencia y Atajos
      position = "top-left";
      toggle_hud = "Shift_R+F12";
    };
  };
}
