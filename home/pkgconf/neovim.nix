{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      base16-nvim # Tema Stylix
    ];
  };
}
