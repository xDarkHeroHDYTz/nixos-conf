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
      gpu_mem_temp = true; # <--- Añadido: Temperatura de la VRAM (requiere que 'vram = true' esté activo)

      # CPU
      cpu_stats = true;
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;

      # Memoria, FPS, Red y Almacenamiento (I/O)
      vram = true;
      ram = true;
      procmem = true;
      fps = true;
      frametime = true;
      io_read = true;
      io_write = true;
      network = true;      # <--- Añadido: Muestra el tráfico de red de tus interfaces activas

      # Métricas de FPS (Muestra AVG y 1% Low)
      fps_metrics = "avg, 0.01";

      # Información del Sistema y Servidor de Pantalla
      display_server = true;
      engine_version = true;
      wine = true;

      # Tamaño, Apariencia y Atajos
      position = "top-left";
      toggle_hud = "Shift_R+F12";
    };
  };
}
