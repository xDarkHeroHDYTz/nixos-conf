_:

{
  xdg.portal.enable = true;

  services.flatpak = {
    enable = true;

    packages = [
      "org.vinegarhq.Sober"
      "org.blender.Blender"
    ];
  };
}
