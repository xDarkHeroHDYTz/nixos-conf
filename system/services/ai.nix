{ pkgs, ... }:

{
  # --- SERVICIO OLLAMA ---
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    host = "0.0.0.0";
    port = 11434;
  };

  # --- OPEN WEBUI VÍA CONTENEDOR GESTIONADO POR NIX ---
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    open-webui = {
      image = "ghcr.io/open-webui/open-webui:main";
      ports = [ "3000:8080" ];
      environment = {
        OLLAMA_BASE_URL = "http://172.17.0.1:11434";
      };
      extraOptions = [ "--network=host" ];
      autoStart = true;
    };

    crawl4ai = {
      image = "unclecode/crawl4ai:latest";
      ports = [ "11235:11235" ];
      environment = {
        API_PORT = "11235";
        CRAWL4AI_API_TOKEN = "*xy7Yukl0PZIqQK3fZ&padAu";
      };
      extraOptions = [
        "--shm-size=1g"
        "--network=host"
      ];
      autoStart = true;
    };
  };

  # --- SERVICIO SEARXNG ---
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      server = {
        bind_address = "0.0.0.0";
        port = 8888;
        secret_key = "*xy7Yukl0PZIqQK3fZ&padAu";
      };
      search.formats = [ "html" "json" ];
    };
  };
}
