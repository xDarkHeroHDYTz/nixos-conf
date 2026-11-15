{ lib, pkgs, ... }:

let
  productIds = [
    # Modos normales y de actualización (incluyendo 6f03 para el Upgrader/Bootloader)
    "3265" "3245" "3255" "3275" "32f5" "3302" "3235" "fee0" "1026" "0720"
    "2620" "6112" "6f03" "1028" "0722" "6120" "fe70" "102a" "6130" "1030"
    "0730" "1037" "0737" "103b" "1036" "102b" "072b"
  ];

  nuphyUdev = pkgs.writeTextDir "etc/udev/rules.d/60-nuphy.rules" ''
    # Nuphy Devices (USB y HIDRAW)
    ${lib.concatMapStringsSep "\n" (pid: ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="19f5", ATTR{idProduct}=="${pid}", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="${pid}", TAG+="uaccess"
    '') productIds}
  '';
in
{
  services.udev.packages = [ nuphyUdev ];
}
