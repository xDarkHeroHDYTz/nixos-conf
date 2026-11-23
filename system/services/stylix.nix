{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";

    opacity = {
      applications = 0.90;
      terminal = 0.85;
      popups = 1.0;
      desktop = 0.85;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 10;
      };
    };
  };
  home-manager.users.lisandro = {
    stylix.targets.wayprompt.enable = false; # Arreglo temporal para poder reconstruir el sistema.
  };
}
