{ pkgs, ... }:

{
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu;
        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
        swtpm.enable = true;

        # Permisos de dispositivos NVIDIA y de renderizado para EGL/VirtIO-3D
        verbatimConfig = ''
          namespaces = []
          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm",
              "/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset",
              "/dev/nvidia-uvm", "/dev/nvidia-uvm-tools",
              "/dev/dri/renderD128", "/dev/dri/renderD129"
          ]
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dnsmasq
    virtio-win
    vulkan-tools
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
