{ config, pkgs, ... }:

let
  artcraftTokenPath = config.sops.secrets."control_token".path;
  openrouterKeyPath = config.sops.secrets."openrouter_api_key".path;
in
{
  programs.opencode = {
    enable = true;
    settings = {
      tools = {
        bash = true;
        read = true;
        edit = true;
        write = true;
        grep = true;
        glob = true;
        list = true;
        webfetch = true;
      };

      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama";
          options = {
            baseURL = "http://127.0.0.1:11434/v1";
          };
        };

        openrouter = {
          npm = "@ai-sdk/openai-compatible";
          name = "OpenRouter";
          options = {
            baseURL = "https://openrouter.ai/api/v1";
            apiKey = "{file:${openrouterKeyPath}}";
            headers = {
              "HTTP-Referer" = "https://localhost";
              "X-Title" = "OpenCode";
            };
          };
        };
      };

      mcp = {
        photocraft-bridge = {
          type = "local";
          command = [
            "photocraft-cli"
            "mcp"
            "--bridge"
            "127.0.0.1:7878"
            "--control-token-file"
            artcraftTokenPath
          ];
        };

        filmcraft-bridge = {
          type = "local";
          command = [
            "${pkgs.bash}/bin/bash"
            "-c"
            ''export FILMCRAFT_CONTROL_TOKEN=$(${pkgs.coreutils}/bin/tr -d ' \n' < "${artcraftTokenPath}"); exec filmcraft-cli --bridge 127.0.0.1:7879 mcp''
          ];
        };

        cadcraft-bridge = {
          type = "local";
          command = [
            "cadcraft-cli"
            "mcp"
            "--connect"
            "127.0.0.1:7880"
            "--lazy"
          ];
        };

        vectorcraft-bridge = {
          type = "local";
          command = [
            "vectorcraft-cli"
            "mcp"
            "--connect"
            "127.0.0.1:7979"
          ];
        };
      };
    };
  };

  programs.fish = {
    functions = {
      pc-ctrl = {
        description = "Abre PhotoCraft en modo control (127.0.0.1:7878)";
        body = ''
          photocraft --control 7878 --control-token-file "${artcraftTokenPath}" $argv >/dev/null 2>&1 &
          disown
        '';
      };

      fc-ctrl = {
        description = "Abre FilmCraft en modo control (127.0.0.1:7879)";
        body = ''
          set -lx FILMCRAFT_CONTROL_TOKEN (string trim < "${artcraftTokenPath}")
          filmcraft --control 7879 $argv >/dev/null 2>&1 &
          disown
        '';
      };

      cc-ctrl = {
        description = "Abre CADCraft en modo control (127.0.0.1:7880)";
        body = ''
          cadcraft --control 7880 $argv >/dev/null 2>&1 &
          disown
        '';
      };

      vc-ctrl = {
        description = "Abre VectorCraft en modo control (127.0.0.1:7979)";
        body = ''
          set -lx VECTORCRAFT_CONTROL_PORT 7979
          vectorcraft --control 7979 $argv >/dev/null 2>&1 &
          disown
        '';
      };
    };
  };

  # Prompt del sistema.
  home.file.".config/opencode/AGENTS.md".text = ''
    # Entorno
    NixOS declarativo (Flakes, Home Manager en `~/.nixos-conf`), Wayland, Fish.

    # Capacidades
    - **Nix:** `nix run nixpkgs#<pkg> -- <args>`, `nix shell nixpkgs#<pkg> -c <cmd>`, `nix-shell -p <pkg>` y `nix develop` para software temporal. Buscar con `nix search nixpkgs <query>`. Validar con `nix flake check`, `nix build`, `nix eval`, `nix fmt`. Cambios permanentes vía NixOS/Home Manager; nunca `nix-env`.
    - **Sistema:** Diagnosticar con `systemctl`, `journalctl`, `ss`, `ps`, `ip`, `lsblk`, `lspci`, `lsusb`, `free`, `df`, `nvidia-smi`, `ollama ps`. Wayland: `wl-paste`/`wl-copy`. Fish: usar `bash -c` para sintaxis incompatible.
    - **MCP:** Priorizar MCP sobre GUI. Si falla un puente de control, revisar funciones `*-ctrl` o avisar.

    # Seguridad
    - `/nix/store` es inmutable; no editar archivos de `/etc` generados por NixOS. Cambios mediante `.nix`.
    - Nunca exponer secretos (`/run/secrets/`).
    - Lectura y comandos efímeros libres. Pedir confirmación antes de `nixos-rebuild switch`, `home-manager switch` o acciones destructivas.

    # Criterios
    Inspeccionar antes de asumir. Priorizar soluciones simples, declarativas y reproducibles. Validar antes de terminar.
  '';
}
