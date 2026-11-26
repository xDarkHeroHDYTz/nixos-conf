# NixOS Configuration

Configuración modular para dos hosts: **PC** (Ryzen + RTX 4070) y **Laptop** (i7-8750H + RTX 2060 + Intel UHD 630).

## Estructura

```
├── flake.nix                 # Entrada principal
├── hosts/
│   ├── pc/                   # Configuración PC
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   ├── lisandro.nix
│   │   └── theme.nix
│   └── laptop/               # Configuración Laptop
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       ├── lisandro.nix
│       └── theme.nix
├── system/                   # Módulos de sistema
│   ├── core/
│   ├── desktop/
│   ├── greeter/
│   ├── hardware/
│   └── services/
├── home/                     # Módulos de usuario
│   ├── niri/
│   ├── pkgconf/
│   └── secrets/
└── wallpapers/
```

## Instalación rápida

```bash
# 1. Clonar
git clone https://github.com/xDarkHeroHDYTz/nixos-conf ~/.nixos-conf
cd ~/.nixos-conf

# 2. Hardware configuration (solo primera vez)
# PC:
sudo cp /etc/nixos/hardware-configuration.nix hosts/pc/
# Laptop:
sudo cp /etc/nixos/hardware-configuration.nix hosts/laptop/

# 3. Secrets (sops/age)
# Generar clave age si no existe:
# age-keygen -o ~/.config/sops/age/keys.txt
# Editar .sops.yaml con tu clave pública
# nix-shell -p sops age
# sops home/secrets/secrets.yaml

# 4. Rebuild
# PC:
sudo nixos-rebuild switch --flake .#pc
# Laptop:
sudo nixos-rebuild switch --flake .#laptop
```

## Secure Boot + TPM2 (LUKS)

```bash
# 1. Keys
nix-shell -p sbctl
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft

# 2. TPM2 enrollment (desbloqueo automático)
# Requiere kernel con CONFIG_TPM2=y y systemd-cryptenroll
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 --tpm2-with-pin=yes /dev/disk/by-uuid/<UUID_ROOT>
# Repetir para swap si se desea

# 3. Verificar
sbctl verify
```

## Comandos útiles

```bash
# Actualizar flake
nfu         # nix flake update --flake ~/.nixos-conf

# Rebuild
nrt         # nixos-rebuild test --flake ~/.nixos-conf#$HOST
nrs         # nixos-rebuild switch --flake ~/.nixos-conf#$HOST

# Limpieza
ncg         # nix-collect-garbage -d
nso         # nix-store --optimise -vv

# Con nh (recomendado): muestra diff, limpia generaciones viejas
nh os switch
```

## Hosts

| Host | CPU | GPU | Desktop | Kernel sleep |
|------|-----|-----|---------|--------------|
| pc | Ryzen | RTX 4070 (dedicada) | Niri + Noctalia | deep (S3) |
| laptop | i7-8750H | RTX 2060 + Intel UHD 630 (Prime) | Niri + Noctalia | deep |

## Características principales

- **WM**: Niri (scrollable-tiling) con Noctalia (launcher/paneles)
- **Estilo**: Stylix (Gruvbox-warm en PC, Nord en Laptop)
- **Seguridad**: sops/age para secrets, firewall nftables (zona drop), DNS-over-TLS, LibreWolf hardened
- **Gaming**: Steam + WIVRN + gamemode + mangohud + Proton (NVAPI, NTSync)
- **Creatividad**: Artcraft suite (Photo/Film/CAD/Vector) vía MCP en OpenCode
- **IA local**: Ollama (CUDA) en 127.0.0.1:11434
- **Virtualización**: KVM/QEMU + VirGL + passthrough NVIDIA
- **Autoupgrade**: Diario 05:00 (solo con AC), desde este repo

## Diferencias PC vs Laptop

| Aspecto | PC | Laptop |
|---------|-----|--------|
| Teclado | us altgr-intl | latam |
| Monitores | 2 (1440p 180/280Hz) | 1 (1080p 144Hz) |
| NVIDIA | open = true (Turing+) | open = true (Turing) |
| Energía | power-profiles-daemon | TLP + undervolt + thermald |
| Cybersecurity tools | No | Sí |
| Wireshark | No | Sí |

## Wallpapers

Noctalia incluye un navegador de Wallhaven (`Mod+Shift+W`). El wallpaper de Stylix en PC es `wallhaven-xlger3.jpg`.

## Troubleshooting

- **Niri no inicia**: revisa `journalctl --user -u niri`
- **Noctalia no aparece**: `systemctl --user status noctalia`
- **Audio Audient**: script en `system/hardware/audient.nix` maneja suspend/resume
- **Teclado NuPhy**: reglas udev en `system/hardware/nuphy.nix`
- **LUKS no desbloquea con TPM**: `systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 --wipe-slot=X /dev/...` y re-enroll