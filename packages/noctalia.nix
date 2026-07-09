{ config, pkgs, ... }:

{
  xdg.configFile."noctalia/config.toml" = {
    force = true;
    text = ''
      [bar]
      enable = true
      position = "top"
      height = 32
      monitors = ["all"]

      [launcher]
      enable = true
      terminal = "alacritty"

      [dock]
      enable = true
      position = "bottom"
      icon_size = 48
      pinned_apps = ["alacritty", "librewolf", "dolphin"]

      [wallpaper]
      enable = true
      directory = "/home/lisandro/Pictures/Wallpapers"
      mode = "random"

      [theme]
      font = "JetBrainsMono Nerd Font"
      accent_color = "#7fc8ff"

      # Template manual para Obsidian
      [theme.templates.user.obsidian_direct]
      input_path  = "/home/lisandro/.local/state/noctalia/community-templates/obsidian/obsidian.css"
      output_path = "/home/lisandro/Documents/Obsidian Vault/.obsidian/snippets/noctalia.css"

      # Template manual para los Iconos Papirus
      [theme.templates.user.papirus_direct]
      input_path  = "/home/lisandro/.local/state/noctalia/community-templates/papirus-folders/colors-final"
      output_path = "/home/lisandro/.local/share/icons/Papirus-Dark-Noctalia/colors-final"
      # El comando 'exec' corre justo después de escribir el archivo para aplicar el color y refrescar la caché
      exec        = "papirus-folders -t Papirus-Dark-Noctalia -d /home/lisandro/.local/share/icons/Papirus-Dark-Noctalia --theme custom && gtk-update-icon-cache -f -t /home/lisandro/.local/share/icons/Papirus-Dark-Noctalia"
    '';
  };
}
