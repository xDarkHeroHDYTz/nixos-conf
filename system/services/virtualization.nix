{pkgs, ...}:

{
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu;
        vhostUserPackages = with pkgs; [
          /*
          NOTA:
          Los invitados de Windows necesitan descargar estas herramientas:
          - virtio-win-guest-tools
          - winfsp
          luego habilita virtio desde service.msc, después también inicia
          */
          virtiofsd
          virtio-win
        ];
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # Usa esto cuando uses NixOS como invitado
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;  # habilitar copiar y pegar entre el host y el invitado
}
