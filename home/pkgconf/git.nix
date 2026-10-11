{ config, ... }:

{
  sops.templates."git-extra" = {
    path = "${config.home.homeDirectory}/.config/git/sops-extra.inc";
    mode = "0600";
    content = ''
      [url "https://xDarkHeroHDYTz:${config.sops.placeholder.git_token}@github.com/"]
        insteadOf = https://github.com/
    '';
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
    };
    includes = [
      { path = "${config.home.homeDirectory}/.config/git/sops-extra.inc"; }
    ];
  };
}
