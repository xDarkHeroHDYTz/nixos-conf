_:

{
  services = {
    fwupd.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;
}
