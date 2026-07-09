{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal = {
        shell = {
          program = "${pkgs.fish}/bin/fish";
          args = [ "--login" ];
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      ns = "sudo nixos-rebuild switch --impure --flake /home/lisandro/.nixos-conf/#nixos";
      cg = "sudo nix-collect-garbage -d";
      ytpl-dl = "yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --embed-metadata -o \"/home/lisandro/Music/%(playlist)s/%(title)s.%(ext)s\"";
      zed = "sudo -E zeditor";
      ll = "ls -lh";
      la = "ls -la";
      comfyui = "nix run github:utensils/comfyui-nix#cuda -- --enable-manager";
    };
    shellInit = ''
      set -gx ZED_ALLOW_ROOT "true"
      set -g fish_greeting ""
    '';
    interactiveShellInit = ''
      fastfetch
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableNushellIntegration = false;
    enableFishIntegration = true;
    # settings = {};
  };
}
