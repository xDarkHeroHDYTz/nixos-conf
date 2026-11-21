{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    operation = "boot"; # Construye y prepara el arranque sin tocar la sesión en curso

    flake = "github:xDarkHeroHDYTz/nixos-conf/main";
    flags = [
      "--no-write-lock-file" # Evita que intente escribir el lockfile en el repositorio remoto
      "-L"                    # Muestra los logs de compilación en el journal
    ];

    dates = "05:00";
    randomizedDelaySec = "45min"; # Retraso aleatorio para evitar picos
  };

  # Solo actualiza con el cargador conectado (en la laptop evita compilar con batería).
  # En equipos sin batería, como la PC, systemd da la condición por cumplida.
  systemd.services.nixos-upgrade.unitConfig.ConditionACPower = true;
}
