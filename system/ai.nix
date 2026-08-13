{ pkgs, ... }:

{
  # --- SERVICIO OLLAMA CON SOPORTE CUDA ---
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    host = "127.0.0.1";
    port = 11434;
  };

  # --- SERVICIO OPEN WEBUI NATIVO ---
  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 3000;
    openFirewall = true;
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
  };

  # --- SERVICIO SEARXNG ---
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      server = {
        bind_address = "0.0.0.0";
        port = 8080;
        secret_key = "*xy7Yukl0PZIqQK3fZ&padAu";
      };
      search = {
        formats = [
          "html"
          "json"
        ];
      };
    };
  };
}
