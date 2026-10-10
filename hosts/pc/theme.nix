{ pkgs, ... }:

{
  stylix = {
    image = ../../wallpapers/wallhaven-5gvx23.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

    icons = {
      enable = true;
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
      package = pkgs.gruvbox-plus-icons.override {
        folder-color = "red";
      };
    };
  };
}
