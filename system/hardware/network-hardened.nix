{ lib, ... }:
# Permisos seguros y nombre corto (límite de 15 caracteres en interfaz)
# chmod 600 /home/lisandro/.config/vpn/nixos-wg-US-FREE-72.conf && cp /home/lisandro/.config/vpn/nixos-wg-US-FREE-72.conf /home/lisandro/.config/vpn/pvpn-us72.conf

# Importar y levantar Proton VPN en NetworkManager
# nmcli connection import type wireguard file /home/lisandro/.config/vpn/pvpn-us72.conf
# nmcli connection up pvpn-us72

# Registrar/aceptar términos, pasar a WireGuard (evita CF_HAPPY_EYEBALLS_MITM_FAILURE) y conectar WARP
# warp-cli settings
# warp-cli registration new
# warp-cli tunnel protocol set WireGuard
# warp-cli mode warp
# warp-cli connect

# Alternar sin chocar rutas ni DNS
# warp-cli disconnect; and nmcli connection up pvpn-us72
# nmcli connection down pvpn-us72; and warp-cli connect

# Verificar estado, IP y DNS
# curl -s https://www.cloudflare.com/cdn-cgi/trace | grep -E "warp=|ip=|loc="
# curl -s https://ipinfo.io/ip; echo
# resolvectl status

{
  networking = {
    wireguard.enable = true;
    networkmanager = {
      wifi.scanRandMacAddress = true;
      wifi.macAddress = "random";
      dns = "systemd-resolved";
    };
    firewall = {
      allowPing = false;
      # "loose" evita bloqueos al alternar entre WARP y túneles WireGuard
      checkReversePath = "loose";

      # Firewall de entrada completamente cerrado: anula TODOS los puertos que abra cualquier
      # otro módulo (Steam, WiVRn, LocalSend...). La salida de red no se restringe.
      allowedTCPPorts = lib.mkForce [ ];
      allowedUDPPorts = lib.mkForce [ ];
      allowedTCPPortRanges = lib.mkForce [ ];
      allowedUDPPortRanges = lib.mkForce [ ];
      interfaces = lib.mkForce { };
    };
  };

  boot.kernel.sysctl = {
    # Reduce exposición a redirecciones ICMP maliciosas y source routing en redes públicas
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.accept_source_route" = false;
    "net.ipv4.conf.default.accept_source_route" = false;
    "net.ipv6.conf.all.accept_source_route" = false;
    "net.ipv6.conf.default.accept_source_route" = false;
    # Este equipo no es router: no emitir redirecciones
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    # Protege conexiones TCP frente a RST falsificados en TIME-WAIT
    "net.ipv4.tcp_rfc1337" = true;
  };

  services = {
    cloudflare-warp.enable = true;
    resolved.settings.Resolve = {
      enable = true;
      LLMNR = "false";
      DNSSEC = "allow-downgrade";
      DNSOverTLS = "opportunistic";
      FallbackDNS = [ "1.1.1.1" "9.9.9.9" ];
    };
  };
}
