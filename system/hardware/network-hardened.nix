{ ... }:

{
  networking = {
    wireguard.enable = true;
    # Permisos seguros y nombre corto (límite de 15 caracteres en interfaz)
    #   chmod 600 ~/.config/vpn/nixos-wg-US-FREE-72.conf && cp ~/.config/vpn/nixos-wg-US-FREE-72.conf ~/.config/vpn/pvpn-us72.conf
    # Importar Proton VPN en NetworkManager
    #   nmcli connection import type wireguard file ~/.config/vpn/pvpn-us72.conf
    networkmanager = {
      wifi.scanRandMacAddress = true;
      wifi.macAddress = "random";
      dns = "systemd-resolved";
    };

    nftables.enable = true;

    firewall = {
      allowPing = false;
      checkReversePath = "loose"; # "loose" evita bloqueos al alternar entre WARP y túneles WireGuard
    };
  };

  boot.kernel.sysctl = {
    # Ignorar redirecciones ICMP: evita que alguien en una wifi pública desvíe tu tráfico
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
  };

  services = {
    firewalld = {
      enable = true;
      settings.DefaultZone = "drop"; # Redes nuevas o públicas: todo lo entrante se descarta (zona "drop").
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
    # --- WARP: Setup y red de confianza ---
    # Setup
    #   warp-cli registration new
    #   warp-cli tunnel protocol set WireGuard && warp-cli mode warp
    # Para que no choque con el VPN
    #   warp-cli trusted ethernet enable
    # Agregar red de confianza (usa el nombre real de la red, el SSID):
    #   warp-cli trusted ssid add "NOMBRE_WIFI"
    # Quitarla:
    #   warp-cli trusted ssid remove "NOMBRE_WIFI"
    # Nota: WARP tiene que estar conectado (warp-cli connect) para que la regla se aplique.

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
