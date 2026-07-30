{ ... }:

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
      terminal = "ghostty"

      [backdrop]
      enabled        = true
      blur_intensity = 0.5
      tint_intensity = 0.3

      # Template manual para Obsidian
      [theme.templates.user.obsidian_direct]
      input_path  = "~/.local/state/noctalia/community-templates/obsidian/obsidian.css"
      output_path = "~/Documentos/Obsidian Vault/.obsidian/snippets/noctalia.css"
    '';
  };
}
