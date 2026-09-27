{ pkgs, ... }:

{
  programs.steam = {
    theme = pkgs.millenniumThemes.space;

    plugins = with pkgs.millenniumPlugins; [
      extendium
      steam-easygrid
    ];

    # extensions = [
    #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    #   { id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon"; } # steamdb
    # ];
  };
}
