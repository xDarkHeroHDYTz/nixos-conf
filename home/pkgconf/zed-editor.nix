{ pkgs, config, lib, ... }:

let
  # Workaround declarativo: Stylix genera el tema de Zed con `appearance = "unspecified"`.
  # Se deriva en el Nix Store para forzar `appearance = "dark"` y evitar conflictos con Home Manager.
  originalStylixTheme = config.xdg.configFile."zed/themes/stylix.json".source;

  patchedZedTheme = pkgs.runCommand "zed-stylix-patched.json" {
    nativeBuildInputs = [ pkgs.jq ];
    inherit originalStylixTheme;
  } ''
    jq '
      .name = "Stylix Patched" |
      .themes[0].name = "Stylix Patched" |
      .themes[0].appearance = "dark"
    ' "$originalStylixTheme" > $out
  '';
in
{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      theme = lib.mkForce "Stylix Patched";
    };
  };

  xdg.configFile."zed/themes/stylix-patched.json".source = patchedZedTheme;
}
