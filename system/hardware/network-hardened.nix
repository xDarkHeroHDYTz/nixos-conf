{ ... }:
# Permisos seguros y nombre corto (límite de 15 caracteres en interfaz)
# chmod 600 ~/.config/vpn/nixos-wg-US-FREE-72.conf && cp ~/.config/vpn/nixos-wg-US-FREE-72.conf ~/.config/vpn/pvpn-us72.conf

# Importar Proton VPN en NetworkManager
# nmcli connection import type wireguard file ~/.config/vpn/pvpn-us72.conf

# Registrar/aceptar términos, pasar a WireGuard (evita CF_HAPPY_EYEBALLS_MITM_FAILURE) y conectar WARP
# warp-cli registration new
# warp-cli tunnel protocol set WireGuard && warp-cli mode warp

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

    nftables.enable = true;

    firewall = {
      allowPing = false;
      # "loose" evita bloqueos al alternar entre WARP y túneles WireGuard
      checkReversePath = "loose";
    };
  };

  # boot.kernel.sysctl = {
  #   # Reduce exposición a redirecciones ICMP maliciosas y source routing en redes públicas
  #   "net.ipv4.conf.all.accept_redirects" = false;
  #   "net.ipv4.conf.default.accept_redirects" = false;
  #   "net.ipv6.conf.all.accept_redirects" = false;
  #   "net.ipv6.conf.default.accept_redirects" = false;
  #   "net.ipv4.conf.all.accept_source_route" = false;
  #   "net.ipv4.conf.default.accept_source_route" = false;
  #   "net.ipv6.conf.all.accept_source_route" = false;
  #   "net.ipv6.conf.default.accept_source_route" = false;
  #   # Este equipo no es router: no emitir redirecciones
  #   "net.ipv4.conf.all.send_redirects" = false;
  #   "net.ipv4.conf.default.send_redirects" = false;
  #   # Protege conexiones TCP frente a RST falsificados en TIME-WAIT
  #   "net.ipv4.tcp_rfc1337" = true;
  # };

  services = {
    # Redes nuevas o públicas: todo lo entrante se descarta (zona "drop").
    # Solo las conexiones marcadas con la zona "nixos-fw-default" abren los puertos del sistema
    # (los de networking.firewall.allowed*Ports y los openFirewall de cada servicio).
    firewalld = {
      enable = true;
      settings.DefaultZone = "drop";
    };

    # --- Marcar una red como segura / quitarla (ejecutar cada comando por separado) ---
    # Marcar como segura:
    #   nmcli connection modify "NOMBRE_WIFI" connection.zone nixos-fw-default
    # Quitar (vuelve a pública):
    #   nmcli connection modify "NOMBRE_WIFI" connection.zone ""
    # Aplicar el cambio (en fish; en bash usa ";" en vez de "; and"):
    #   nmcli connection down "NOMBRE_WIFI"; and nmcli connection up "NOMBRE_WIFI"
    # Comprobar (la red segura debe estar en nixos-fw-default; las demás en drop):
    #   sudo firewall-cmd --get-active-zones

    cloudflare-warp.enable = true;

    resolved = {
      enable = true;
      settings.Resolve = {
        LLMNR = "false";
        DNSSEC = "allow-downgrade";
        DNSOverTLS = "opportunistic";
        FallbackDNS = [ "1.1.1.1" "9.9.9.9" ];
      };
    };
  };
}
