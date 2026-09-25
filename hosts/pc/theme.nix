{ pkgs, ... }:

{
  stylix = {
    # image = /. + "/home/lisandro/Imágenes/Fondos de pantalla/wallhaven-1p7k83.jpg";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";

    icons = {
      enable = true;
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
      package = pkgs.gruvbox-plus-icons.override {
        folder-color = "orange";
      };
    };
  };
}
