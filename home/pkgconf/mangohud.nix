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
      procmem = true;
      fps = true;
      frametime = true;

      # Métricas de FPS (Muestra AVG y 1% Low)
      fps_metrics = "avg, 0.01";

      # Disco / E/S
      disk_io = true;
      disk_io_read = true;      # Forzar lectura
      disk_io_write = true;     # Forzar escritura

      # Información del Sistema y Servidor de Pantalla
      display_server = true;
      # vulkan_driver = true;
      # architecture = true;
      # resolution = true;

      # Tamaño, Apariencia y Atajos
      font_size_scale = 1.5;
      position = "top-left";
      toggle_hud = "Shift_R+F12";
    };
  };
}
