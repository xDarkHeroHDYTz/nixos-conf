{ config, ... }:

{
  sops.secrets = {
    "git_token" = {};
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xDarkHeroHDYTz";
        email = "ggprocrack901@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "!f() { if [ \"\$1\" = \"get\" ]; then echo \"username=xDarkHeroHDYTz\"; echo \"password=$(cat ${config.sops.secrets.git_token.path})\"; fi; }; f";    };
  };
}
