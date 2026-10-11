{ config, ... }:

{
  sops.secrets."git_token" = {};

  # Creamos un template seguro que sops-nix rellena en tiempo de ejecución
  sops.templates."git-credentials" = {
    content = "https://xDarkHeroHDYTz:${config.sops.placeholder.git_token}@github.com\n";
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

      # Usamos el helper 'store' apuntando directamente al archivo generado por sops-nix
      credential.helper = "store --file ${config.sops.templates."git-credentials".path}";
    };
  };
}
