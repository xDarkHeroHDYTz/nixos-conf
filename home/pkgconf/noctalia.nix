{ pkgs, ... }:

{
  programs.noctalia = {
    enable = true;
  };

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      BindsTo = [ "niri.service" ];
      PartOf = [ "niri.service" ];
      After = [ "niri.service" ];
      # PartOf = [ "graphical-session.target" ];
      # After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.noctalia}/bin/noctalia";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "niri.service" ];
    # Install.WantedBy = [ "graphical-session.target" ];
  };
}
