{ ... }:

{
  services.flatpak.enable = true;

  # Si flatpak falla descomentar (TEST)
  # environment.sessionVariables = {
  #   XDG_DATA_DIRS = [
  #     "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
  #   ];
  # };
}
