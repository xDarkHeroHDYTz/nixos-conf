 { ... }:

{
  services.fwupd.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;
}
