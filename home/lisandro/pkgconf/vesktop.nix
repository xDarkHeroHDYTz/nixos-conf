{ ... }:

{
  programs.vesktop = {
    enable = true;
    settings = {
      hardwareVideoAcceleration = true;
      enableSplashScreen = false;
      splashTheming = false;
      arRPC = true;
    };

    vencord = {
      settings = {
        notifyAboutUpdates = false;
        autoUpdate = false;
        plugins = {
          Translate.enabled = true;
          MessageLogger.enabled = true;
          YoutubeAdblock.enabled = true;
          VolumeBooster.enabled = true;
          ShowMeYourName.enabled = true;
          QuickReply.enabled = true;
          MoreQuickReactions.enabled = true;
          ImageZoom.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          FakeNitro.enabled = true;
          BlurNSFW.enabled = true;
          BetterFolders.enabled = true;
        };
      };
    };
  };
}
