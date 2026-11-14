{ ... }:

{
  programs.mangohud = {
    enable = true;
    # enableSessionWide = true;
    settings = {
      # --- GPU ---
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_power = true;
      gpu_load_change = true;

      # --- VRAM ---
      vram = true;
      # gpu_mem_temp = true;
      gpu_mem_clock = true;

      # --- CPU ---
      cpu_stats = true;
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;

      # --- MEMORIA, ALMACENAMIENTO (I/O) Y RED ---
      ram = true;
      procmem = true;
      io_read = true;
      io_write = true;
      network = true;

      # --- FPS Y RENDIMIENTO ---
      fps = true;
      frametime = true;
      fps_metrics = "avg, 0.01";

      # --- INFORMACIÓN DEL SISTEMA Y JUEGO ---
      display_server = true;
      engine_version = true;
      wine = true;

      # --- APARIENCIA Y ATAJOS ---
      position = "top-left";
      toggle_hud = "Shift_R+F12";
    };
  };
}
