{ ... }:

{
  programs.librewolf = {
    enable = true;
    # profiles = {
    #   default = {
    #     # Tu configuración habitual de LibreWolf
    #   };
    # };
  };

  stylix.targets.librewolf = {
    enable = true;
    profileNames = [ "default" ];
  };
}
