{ pkgs, config, ... }:

{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";

    # image = /. + "/home/lisandro/Imágenes/Fondos de pantalla/wallhaven-1p7k83.jpg";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    opacity = {
      applications = 1.0;
      terminal = 0.9;
      popups = 0.95;
    };

    icons = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
      package = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          find $out/share/icons -type f -name "folder*.svg" -exec sed -i 's/#5294[eE]2/#${config.lib.stylix.colors.base0D}/g' {} +
        '';
      });
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 10;
      };
    };
  };
}
