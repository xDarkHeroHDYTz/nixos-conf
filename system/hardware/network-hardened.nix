{ ... }:
# Restringe permisos por contener la clave privada de WireGuard y crea una copia con nombre corto para respetar el límite de 15 caracteres en nombres de interfaz de Linux
# chmod 600 /home/lisandro/.config/vpn/nixos-wg-US-FREE-72.conf && cp /home/lisandro/.config/vpn/nixos-wg-US-FREE-72.conf /home/lisandro/.config/vpn/pvpn-us72.conf

# Registra el perfil WireGuard en NetworkManager para gestionarlo desde el sistema o terminal
# nmcli connection import type wireguard file /home/lisandro/.config/vpn/pvpn-us72.conf

# Activa la interfaz y enruta el tráfico por el servidor de Proton VPN
# nmcli connection up pvpn-us72

# Muestra la configuración actual de WARP y permite aceptar los términos si aún no estaban aceptados
# warp-cli settings

# Cambia el transporte de MASQUE a WireGuard para evitar bloqueos o fallos CF_HAPPY_EYEBALLS_MITM_FAILURE en la red actual
# warp-cli tunnel protocol set WireGuard

# Configura WARP en modo túnel completo (warp) en lugar de quedar en otro modo
# warp-cli mode warp

# Inicia la conexión de Cloudflare WARP
# warp-cli connect

# Apaga WARP antes de subir Proton VPN para evitar choque de rutas, bucles de comprobación o competencia de DNS
# warp-cli disconnect; and nmcli connection up pvpn-us72

# Baja Proton VPN antes de conectar WARP para que WARP tome la ruta por defecto limpiamente
# nmcli connection down pvpn-us72; and warp-cli connect

# Comprueba si WARP está activo (warp=on) y qué IP y país reporta Cloudflare
# curl -s https://www.cloudflare.com/cdn-cgi/trace | grep -E "warp=|ip=|loc="

# Muestra la IP pública actual con salto de línea para verificar el cambio de salida al usar la VPN
# curl -s https://ipinfo.io/ip; echo

# Revisa qué interfaz y servidor DNS está usando systemd-resolved y detecta posibles fugas
# resolvectl status

{
  # Aleatorización de dirección MAC (evita rastreo entre redes distintas)
  networking = {
    wireguard.enable = true; # Soporte nativo de WireGuard para importar configs de Proton VPN / Windscribe en NetworkManager
    networkmanager = {
      wifi.scanRandMacAddress = true;
      wifi.macAddress = "random";
      # Evita que el DHCP de la red pública sobreescriba tus DNS si el túnel cae
      dns = "systemd-resolved";
    };

    # Endurecimiento básico del firewall y red contra spoofing local
    firewall = {
      # Ignora pings desde otros dispositivos conectados a la misma red pública
      allowPing = false;
      # Nota: se usa "loose" en lugar de "strict" para evitar bloqueos al alternar
      # entre Cloudflare WARP y túneles WireGuard de Proton/RiseupVPN
      checkReversePath = "loose";
    };
  };

  # Soporte para systemd-resolved (previene fugas de DNS)
  services = {
    cloudflare-warp.enable = true; # Túnel rápido de baja latencia (Cloudflare WARP - nodo cercano en Sudamérica)
    resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      fallbackDns = [ "1.1.1.1" "9.9.9.9" ];
    };
  };

  programs.fish = {
    shellAliases = {
      vpnon = "nmcli connection up pvpn-us72";
      vpnoff = "nmcli connection down pvpn-us72";
    };
  };
}
