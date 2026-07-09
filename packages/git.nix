{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "xDarkHeroHDYTz";
    userEmail = "ggprocrack901@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
    };
  };
}
