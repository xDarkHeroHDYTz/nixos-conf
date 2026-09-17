{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command = "${pkgs.fish}/bin/fish --login";
      window-decoration = false;
      gtk-single-instance = true;
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      nfu = "sudo nix flake update --flake ~/.nixos-conf";
      nrt = "sudo nixos-rebuild test --flake ~/.nixos-conf#$hostname";
      nrs = "sudo nixos-rebuild switch --flake ~/.nixos-conf#$hostname";
      ncg = "sudo nix-collect-garbage -d";
      nso = "sudo nix-store --optimise -vv";
      ytpl-dl = "yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata -o \"$XDG_MUSIC_DIR/%(playlist)s/%(title)s.%(ext)s\"";
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
          top = 3;
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
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
        }
        {
          type = "cpu";
          key = "│ ├ ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
        }
        {
          type = "gpu";
          key = "│ ├󰢮 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
        }
        {
          type = "display";
          key = "│ ├󰍹 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
        }
        {
          type = "memory";
          key = "│ ├󰑭 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
        }
        {
          type = "swap";
          key = "│ ├󰓡 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
        }
        {
          type = "disk";
          key = "└ └󰋊 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base09}";
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
          keyColor = "${config.lib.stylix.colors.withHashtag.base0A}";
        }
        {
          type = "kernel";
          key = "│ ├󰌽 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0A}";
        }
        {
          type = "bios";
          key = "│ ├󰖡 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0A}";
        }
        {
          type = "packages";
          key = "│ ├󰏗 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0A}";
        }
        {
          type = "shell";
          key = "└ └󰞷 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0A}";
        }
        "break"
        {
          type = "de";
          key = "󰧨  DE";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
        }
        {
          type = "wm";
          key = "│ ├󱂬 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
        }
        {
          type = "icons";
          key = "│ ├󰀻 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
          format = "{1}";
        }
        {
          type = "cursor";
          key = "│ ├󰆿 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
        }
        {
          type = "custom";
          key = "│ ├󰛖 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
          format = "Mono: ${config.stylix.fonts.monospace.name}";
        }
        {
          type = "custom";
          key = "│ ├󰛖 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
          format = "Sans: ${config.stylix.fonts.sansSerif.name}";
        }
        {
          type = "custom";
          key = "│ ├󰛖 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
          format = "Serif: ${config.stylix.fonts.serif.name}";
        }
        {
          type = "terminal";
          key = "└ └󰆍 ";
          keyColor = "${config.lib.stylix.colors.withHashtag.base0D}";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
        }
        # "break"
        # {
        #   type = "custom";
        #   format = "┌───────────────────────Tiempo───────────────────────┐";
        # }
        # {
        #   type = "command";
        #   key = "  ›  Edad OS ";
        #   keyColor = "${config.lib.stylix.colors.withHashtag.base0E}";
        #   text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference días";
        # }
        # {
        #   type = "uptime";
        #   key = "  ›  Encendido ";
        #   keyColor = "${config.lib.stylix.colors.withHashtag.base0E}";
        # }
        # {
        #   type = "battery";
        #   key = "  ›  Batería ";
        #   keyColor = "${config.lib.stylix.colors.withHashtag.base0E}";
        # }
        # {
        #   type = "custom";
        #   format = "└────────────────────────────────────────────────────┘";
        # }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };

  programs.starship = let
    c = config.lib.stylix.colors.withHashtag;
  in {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = "$cmd_duration$hostname$directory$git_branch$git_status$git_state$fill$c$cpp$python$lua$conda$docker_context$nodejs$rust$golang$package$memory_usage$line_break$character";
      add_newline = true;
      scan_timeout = 10;
      character = {
        success_symbol = "[❯](${c.base0D})";
        error_symbol = "[❯](${c.base08})";
        vimcmd_symbol = "[❮](${c.base0B})";
      };
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 4;
        style = "fg:${c.base00} bg:${c.base0D}";
        format = "[](${c.base0D})[ $path]($style)[](${c.base0D})";
      };
      cmd_duration = {
        min_time = 1000;
        style = "fg:${c.base00} bg:${c.base0C}";
        format = "[](${c.base0C})[󰔛 $duration]($style)[](${c.base0C})";
      };
      git_branch = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0E}";
        format = "[](${c.base0E})[$symbol$branch]($style)[](${c.base0E})";
      };
      git_status = {
        style = "fg:${c.base00} bg:${c.base0A}";
        format = "[](${c.base0A})[ $all_status$ahead_behind ]($style)[](${c.base0A})";
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
        cherry_pick = "[🍒 PICKING](${c.base08})";
        style = "${c.base08}";
      };
      c = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0B}";
        format = "[](${c.base0B})[$symbol($version)]($style)[](${c.base0B})";
      };
      cpp = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0B}";
        format = "[](${c.base0B})[$symbol($version)]($style)[](${c.base0B})";
      };
      python = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0B}";
        format = "[](${c.base0B})[$symbol($version)( \\($virtualenv\\))]($style)[](${c.base0B})";
      };
      lua = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0D}";
        format = "[](${c.base0D})[$symbol($version)]($style)[](${c.base0D})";
        detect_extensions = [ "lua" ];
        detect_files = [ ".luarc.json" ".luarc.jsonc" ];
      };
      conda = {
        style = "fg:${c.base00} bg:${c.base0B}";
        format = "[](${c.base0B})[ $environment]($style)[](${c.base0B})";
        ignore_base = false;
      };
      nodejs = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0B}";
        format = "[](${c.base0B})[$symbol($version)]($style)[](${c.base0B})";
      };
      rust = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0A}";
        format = "[](${c.base0A})[$symbol($version)]($style)[](${c.base0A})";
      };
      golang = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0C}";
        format = "[](${c.base0C})[$symbol($version)]($style)[](${c.base0C})";
      };
      package = {
        symbol = "󰏗 ";
        style = "fg:${c.base00} bg:${c.base0A}";
        format = "[](${c.base0A})[$symbol$version]($style)[](${c.base0A})";
      };
      docker_context = {
        symbol = " ";
        style = "fg:${c.base00} bg:${c.base0D}";
        format = "[](${c.base0D})[$symbol$context]($style)[](${c.base0D})";
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
        style = "fg:${c.base00} bg:${c.base08}";
        format = "[](${c.base08})[󰣀 $hostname]($style)[](${c.base08})";
      };
      username.disabled = true;
    };
  };
}
