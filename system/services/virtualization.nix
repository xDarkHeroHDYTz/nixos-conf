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
          virtio-win
        ];
        swtpm.enable = true;

        # Permisos de dispositivos NVIDIA para la aceleración EGL/VirtIO-3D
        verbatimConfig = ''
          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm",
              "/dev/nvidiactl", "/dev/nvidia0", "/dev/nvidia-modeset",
              "/dev/dri/renderD128"
          ]
          seccomp_sandbox = 0
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dnsmasq
    virglrenderer
    vulkan-tools
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
