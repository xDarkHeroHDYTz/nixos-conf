{ config, pkgs, ... }:

let
  artcraftTokenPath = config.sops.secrets."control_token".path;
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
          enabled = true;
        };

        filmcraft-bridge = {
          type = "local";
          command = [
            "${pkgs.bash}/bin/bash"
            "-c"
            ''export FILMCRAFT_CONTROL_TOKEN=$(${pkgs.coreutils}/bin/tr -d ' \n' < "${artcraftTokenPath}"); exec filmcraft-cli --bridge 127.0.0.1:7879 mcp''
          ];
          enabled = true;
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
          enabled = true;
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
    };
  };
}
