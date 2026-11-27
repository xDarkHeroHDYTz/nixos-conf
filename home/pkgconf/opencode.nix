{ config, pkgs, ... }:

let
  artcraftTokenPath = config.sops.secrets."control_token".path;
  openrouterKeyPath = config.sops.secrets."openrouter_api_key".path;
in
{
  programs.opencode = {
    enable = true;
    settings = {
      compaction = {
        auto = true;
        prune = true;
        reserved = 4096;
      };

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
          models = {
            "ornith-1.5:9b" = {
              name = "Ornith 1.5 9B";
              limit = {
                context = 65536;
                output = 4096;
              };
            };
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
    # Environment
    Declarative NixOS (Flakes, Home Manager at `~/.nixos-conf`), Wayland, Fish.

    # Capabilities
    - **Nix:** `nix run nixpkgs#<pkg> -- <args>`, `nix shell nixpkgs#<pkg> -c <cmd>`, `nix-shell -p <pkg>`, `nix develop`. Search: `nix search nixpkgs <query>`. Validate: `nix flake check`, `nix build`, `nix eval`, `nix fmt`. Permanent installs via `.nix` only; never `nix-env`.
    - **System:** `systemctl`, `journalctl`, `ss`, `ps`, `ip`, `lsblk`, `lspci`, `lsusb`, `free`, `df`, `nvidia-smi`, `ollama ps`. Clipboard: `wl-paste`/`wl-copy`. Use `bash -c` for non-Fish syntax.
    - **MCP:** Prefer MCP over GUI. On bridge connection failure, check `*-ctrl` functions or inform the user.

    # Safety & Criteria
    - `/nix/store` and Nix-generated `/etc` files are immutable: edit `.nix` only. Never expose secrets (`/run/secrets/`).
    - Read-only diagnostics and ephemeral commands are free; confirm before `nixos-rebuild switch`, `home-manager switch`, or destructive actions.
    - Inspect before assuming, keep solutions declarative and reproducible, validate before finishing.
  '';
}
