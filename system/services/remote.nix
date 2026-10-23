{ ... }:

{
  users.users.lisandro = {
    extraGroups = [ "uinput" "input" ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
  };

  services.zerotierone = {
    enable = true;
  };
}
