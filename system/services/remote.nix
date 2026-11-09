{ ... }:

{
  services.zerotierone = {
    enable = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
  };

  programs.moonlight-qt = {
    enable = true;
    capSysNice = true;
  };
}
