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

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    # settings = {};
  };
}
