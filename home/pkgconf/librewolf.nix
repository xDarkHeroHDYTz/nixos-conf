{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    profiles = {

      default = {
        id = 0;
        isDefault = true;
        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            adaptive-tab-bar-colour
            ambient-light-for-youtube
            bitwarden
            clearurls
            consent-o-matic
            darkreader
            localcdn
            proton-vpn
            search-by-image
            sponsorblock
            tablissng
            ublock-origin
          ];
        };
      };

      private = {
        id = 1;
        isDefault = false;
        extensions.force = true;
      };
    };
  };

  stylix.targets.librewolf = {
    enable = true;
    colorTheme.enable = true;
    profileNames = [ "default" "private" ];
  };
}
