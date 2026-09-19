{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
  };

  home.activation.fixZedThemeAppearance = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    THEME_FILE="$HOME/.config/zed/themes/stylix.json"
    if [ -L "$THEME_FILE" ] || [ -f "$THEME_FILE" ]; then
      REAL_FILE=$(readlink -f "$THEME_FILE")
      if [ -f "$REAL_FILE" ]; then
        TEMP_FILE=$(mktemp)
        ${pkgs.gnused}/bin/sed 's/"appearance": "unspecified"/"appearance": "dark"/g' "$REAL_FILE" > "$TEMP_FILE"
        rm -f "$THEME_FILE"
        mv "$TEMP_FILE" "$THEME_FILE"
        chmod 644 "$THEME_FILE"
      fi
    fi
  '';
}
