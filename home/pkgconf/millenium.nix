{ pkgs, ... }:

{
  programs.steam = {
    theme = pkgs.millenniumThemes.space;

    plugins = with pkgs.millenniumPlugins; [
      extendium
      protondb
      steam-native-notifications
    ];

    extensions = [
      { id = "fcjljapncagfmfhdkccgnbkgdpbcefcj"; } # Steamcito
      { id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon"; } # SteamDB
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin
    ];
  };
}
