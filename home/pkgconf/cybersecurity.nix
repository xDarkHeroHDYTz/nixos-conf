{ pkgs, pkgs-stable, ... }:

{
  home.packages = with pkgs; [
    # ==========================================
    # RED TEAM: Reconocimiento y Escaneo
    # ==========================================
    nmap          # Escáner de redes y puertos clásico
    masscan       # Escáner de puertos TCP a alta velocidad
    rustscan      # Escáner de puertos rápido escrito en Rust
    netcat        # Utilidad de red para leer/escribir conexiones
    dnsutils      # Herramientas de consulta DNS (dig, nslookup, etc.)
    whois         # Consulta de información de dominios e IPs

    # ==========================================
    # RED TEAM: Explotación y Redes
    # ==========================================
    metasploit    # Framework de pruebas de penetración
    sqlmap        # Automatización de detección y explotación de SQLi
    hydra         # Probador de fuerza bruta de credenciales rápido
    john          # Herramienta de descifrado de contraseñas (John the Ripper)
    hashcat       # Recuperador de hashes avanzado basado en GPU
    socat         # Relé bidireccional de datos de red avanzado
    proxychains-ng # Enrutamiento de conexiones a través de proxies (SOCKS4/5, Tor)

    # ==========================================
    # RED TEAM: Análisis Web y API
    # ==========================================
    burpsuite     # Plataforma integrada para pruebas de seguridad web
    gobuster      # Herramienta de fuerza bruta para directorios/DNS escrita en Go
    ffuf          # Fuzzer web rápido escrito en Go
    nikto         # Escáner de vulnerabilidades web

    # ==========================================
    # BLUE TEAM: Análisis Forense e Incidentes (DFIR)
    # ==========================================
    wireshark     # Analizador de protocolos de red (con interfaz gráfica)
    tcpdump       # Analizador de tráfico de red por línea de comandos
    # tshark        # Versión de Wireshark para línea de comandos
    volatility3   # Framework avanzado de análisis de memoria RAM
    foremost      # Herramienta de recuperación de archivos (carving)
    binwalk       # Herramienta para análisis y extracción de firmware

    # ==========================================
    # BLUE TEAM: Análisis de Malware y Monitoreo
    # ==========================================
    yara          # Herramienta de identificación y clasificación de malware
    strace        # Diagnóstico y depuración de llamadas al sistema (syscalls)
    ltrace        # Seguimiento de llamadas a bibliotecas dinámicas
    jq            # Procesador JSON por línea de comandos (ideal para parsear logs)

    lynis         # Audita el sistema por vulnerabilidadesl
  ];
}
