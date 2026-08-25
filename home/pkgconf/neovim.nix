{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      base16-nvim
    ];
    initLua = ''
      pcall(function()
        require('matugen').setup()
      end)
    '';
  };

  xdg.configFile."nvim/lua/matugen-template.lua".text = ''
    local M = {}

    function M.setup()
      require('base16-colorscheme').setup {
        -- Background tones
        base00 = '{{colors.surface.default.hex}}', -- Default Background
        base01 = '{{colors.surface_container.default.hex}}', -- Lighter Background
        base02 = '{{colors.surface_container_high.default.hex}}', -- Selection Background
        base03 = '{{colors.outline.default.hex}}', -- Comments
        -- Foreground tones
        base04 = '{{colors.on_surface_variant.default.hex}}', -- Dark Foreground
        base05 = '{{colors.on_surface.default.hex}}', -- Default Foreground
        base06 = '{{colors.on_surface.default.hex}}', -- Light Foreground
        base07 = '{{colors.on_background.default.hex}}', -- Lightest Foreground
        -- Accent colors
        base08 = '{{colors.error.default.hex}}', -- Variables, Errors
        base09 = '{{colors.tertiary.default.hex}}', -- Constants
        base0A = '{{colors.secondary.default.hex}}', -- Search, Classes
        base0B = '{{colors.primary.default.hex}}', -- Strings
        base0C = '{{colors.tertiary_fixed_dim.default.hex}}', -- Escape chars
        base0D = '{{colors.primary_fixed_dim.default.hex}}', -- Functions
        base0E = '{{colors.secondary_fixed_dim.default.hex}}', -- Keywords
        base0F = '{{colors.error_container.default.hex}}', -- Embedded tags
      }
    end

    -- Recarga en caliente cuando Noctalia envía la señal SIGUSR1 a Neovim
    local signal = vim.uv.new_signal()
    signal:start(
      'sigusr1',
      vim.schedule_wrap(function()
        package.loaded['matugen'] = nil
        require('matugen').setup()
      end)
    )

    return M
  '';

  xdg.configFile."noctalia/user-templates.toml".text = ''
    [templates.nvim-base16]
    input_path = "~/.config/nvim/lua/matugen-template.lua"
    output_path = "~/.config/nvim/lua/matugen.lua"
    post_hook = 'pkill -SIGUSR1 nvim'
  '';
}
