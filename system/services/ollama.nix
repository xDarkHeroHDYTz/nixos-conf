{ pkgs, ... }:

{
  # --- SERVICIO OLLAMA ---
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    host = "127.0.0.1";
    port = 11434;
    loadModels = [
      "ornith-1.5:9b"
      "qwen3.5:9b"
      "mimo-v2.6:9b"
      "gemma4:12b"
    ];
    environmentVariables = {
      # Contexto por defecto (el mismo definido en home/pkgconf/opencode.nix).
      OLLAMA_CONTEXT_LENGTH = "65536";
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };
}
