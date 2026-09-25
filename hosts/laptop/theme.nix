{ pkgs, ... }:

{
  stylix = {
    # image = /. + "/home/lisandro/Imágenes/Fondos de pantalla/wallhaven-1p7k83.jpg";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    icons = {
      enable = true;
      dark = "Tela-nord-dark";
      light = "Tela-nord";
      package = pkgs.tela-icon-theme;
    };
  };
}
