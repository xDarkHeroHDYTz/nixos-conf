{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xDarkHeroHDYTz";
        email = "ggprocrack901@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      credential = {
        helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
      };
    };
  };
}
