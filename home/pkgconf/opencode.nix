{ config, ... }:

let
  photoToken = "${config.xdg.configHome}/photocraft/control.token";
  filmToken  = "${config.xdg.configHome}/filmcraft/control.token";
in
{
  programs.opencode = {
    enable = true;
    settings = {
      mcp = {
        photocraft-bridge = {
          type = "local";
          command = [
            "photocraft-cli"
            "mcp"
            "--bridge"
            "127.0.0.1:7878"
            "--control-token-file"
            photoToken
          ];
          enabled = true;
        };

        filmcraft-bridge = {
          type = "local";
          command = [
            "filmcraft-cli"
            "mcp"
            "--bridge"
            "127.0.0.1:7879"
            "--control-token-file"
            filmToken
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
}
