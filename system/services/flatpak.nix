{ ... }:

{
  services.flatpak = {
    enable = true;

    packages = [
      "org.vinegarhq.Sober"
      "org.blender.Blender"
    ];

    update.onActivation = true;
  };

  # Si flatpak falla descomentar (TEST)
  # environment.sessionVariables = {
  #   XDG_DATA_DIRS = [
  #     "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
  #   ];
  # };
}
