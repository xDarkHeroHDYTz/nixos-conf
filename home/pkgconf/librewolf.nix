{ ... }:

{
  programs.librewolf = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        isDefault = true;
      };
      private = {
        id = 1;
        isDefault = false;
      };
    };
  };

  stylix.targets.librewolf = {
    enable = true;
    profileNames = [ "default" "private" ];
  };
}
