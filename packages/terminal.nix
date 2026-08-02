{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command = "${pkgs.fish}/bin/fish --login";
      theme = "noctalia";
      window-decoration = false;
      gtk-single-instance = true;
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      ns = "sudo nixos-rebuild switch --impure --flake ~/.nixos-conf && noctalia msg templates-apply";
      cg = "sudo nix-collect-garbage -d";
      ytpl-dl = "yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata -o \"~/Música/%(playlist)s/%(title)s.%(ext)s\"";
      comfyui = "nix run github:utensils/comfyui-nix#cuda -- --enable-manager";
    };
    shellInit = ''
      set -g fish_greeting ""
    '';
    interactiveShellInit = ''
      fastfetch
    '';
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "builtin";
        height = 15;
        width = 30;
        padding = {
          top = 5;
          left = 3;
        };
      };
      modules = [
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Hardware──────────────────────┐";
        }
        {
          type = "host";
          key = "󰌢  PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├ ";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰢮 ";
          keyColor = "green";
        }
        {
          type = "display";
          key = "│ ├󰍹 ";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "│ ├󰑭 ";
          keyColor = "green";
        }
        {
          type = "swap";
          key = "│ ├󰓡 ";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "└ └󰋊 ";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌──────────────────────Software──────────────────────┐";
        }
        {
          type = "os";
          key = "  OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├󰌽 ";
          keyColor = "yellow";
        }
        {
          type = "bios";
          key = "│ ├󰖡 ";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏗 ";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "└ └󰞷 ";
          keyColor = "yellow";
        }
        "break"
        {
          type = "de";
          key = "󰧨  DE";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "│ ├󱂬 ";
          keyColor = "blue";
        }
        {
          type = "icons";
          key = "│ ├󰀻 ";
          keyColor = "blue";
        }
        {
          type = "cursor";
          key = "│ ├󰆿 ";
          keyColor = "blue";
        }
        {
          type = "font";
          key = "│ ├󰛖 ";
          keyColor = "blue";
          format = "{3}";
        }
        {
          type = "terminal";
          key = "└ └󰆍 ";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        "break"
        {
          type = "custom";
          format = "┌───────────────────────Tiempo───────────────────────┐";
        }
        {
          type = "command";
          key = "  ›  Edad OS ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference días";
        }
        {
          type = "uptime";
          key = "  ›  Encendido ";
          keyColor = "magenta";
        }
        {
          type = "battery";
          key = "  ›  Batería ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = "$cmd_duration$hostname$directory$git_branch$git_status$git_state$fill$c$cpp$python$lua$conda$docker_context$nodejs$rust$golang$package$memory_usage$line_break$character";

      add_newline = true;
      scan_timeout = 10;

      character = {
        success_symbol = "[❯](blue)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 4;
        style = "fg:black bg:blue";
        format = "[](blue)[ $path]($style)[](blue)";
      };

      cmd_duration = {
        min_time = 1000;
        style = "fg:black bg:cyan";
        format = "[](cyan)[󰔛 $duration]($style)[](cyan)";
      };

      git_branch = {
        symbol = " ";
        style = "fg:black bg:purple";
        format = "[](purple)[$symbol$branch]($style)[](purple)";
      };

      git_status = {
        style = "fg:black bg:yellow";
        format = "[](yellow)[ $all_status$ahead_behind ]($style)[](yellow)";
        conflicted = "⚔ ";
        ahead = "↑$count ";
        behind = "↓$count ";
        diverged = "↕ ";
        up_to_date = "✓ ";
        untracked = "$count ";
        modified = "$count ";
        staged = "$count ";
        deleted = "$count ";
        renamed = "󰑕$count ";
        stashed = "󰏗 ";
      };

      git_state = {
        format = "[\\($state( $progress_current of $progress_total)\\)]($style) ";
        cherry_pick = "[🍒 PICKING](red)";
        style = "red";
      };

      c = {
        symbol = " ";
        style = "fg:black bg:green";
        format = "[](green)[$symbol($version)]($style)[](green)";
      };

      cpp = {
        symbol = " ";
        style = "fg:black bg:green";
        format = "[](green)[$symbol($version)]($style)[](green)";
      };

      python = {
        symbol = " ";
        style = "fg:black bg:green";
        format = "[](green)[$symbol($version)( \\($virtualenv\\))]($style)[](green)";
      };

      lua = {
        symbol = " ";
        style = "fg:black bg:blue";
        format = "[](blue)[$symbol($version)]($style)[](blue)";
        detect_extensions = [ "lua" ];
        detect_files = [ ".luarc.json" ".luarc.jsonc" ];
      };

      conda = {
        style = "fg:black bg:green";
        format = "[](green)[ $environment]($style)[](green)";
        ignore_base = false;
      };

      nodejs = {
        symbol = " ";
        style = "fg:black bg:green";
        format = "[](green)[$symbol($version)]($style)[](green)";
      };

      rust = {
        symbol = " ";
        style = "fg:black bg:yellow";
        format = "[](yellow)[$symbol($version)]($style)[](yellow)";
      };

      golang = {
        symbol = " ";
        style = "fg:black bg:cyan";
        format = "[](cyan)[$symbol($version)]($style)[](cyan)";
      };

      package = {
        symbol = "󰏗 ";
        style = "fg:black bg:yellow";
        format = "[](yellow)[$symbol$version]($style)[](yellow)";
      };

      docker_context = {
        symbol = " ";
        style = "fg:black bg:blue";
        format = "[](blue)[$symbol$context]($style)[](blue)";
        only_with_files = false;
        detect_extensions = [ ];
        detect_files = [ ];
        detect_folders = [ ];
      };

      fill.symbol = " ";

      battery.disabled = true;
      time.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;

      hostname = {
        ssh_only = true;
        style = "fg:black bg:red";
        format = "[](red)[󰣀 $hostname]($style)[](red)";
      };

      username.disabled = true;
    };
  };
}
