{ lib, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  systemd.user.services.noctalia = {
    Unit = {
      BindsTo = lib.mkForce [ "niri.service" ];
      PartOf = lib.mkForce [ "niri.service" ];
      After = lib.mkForce [ "niri.service" ];
    };
    Install = {
      WantedBy = lib.mkForce [ "niri.service" ];
    };
  };
}
