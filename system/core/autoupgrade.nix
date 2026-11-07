{ ... }:

{
  system.autoUpgrade = {
    enable = true;

    # Apunta a tu repositorio de GitHub y rama principal (ej. main o master)
    flake = "github:xDarkHeroHDYTz/nixos-conf/main";

    # Flags esenciales para actualizaciones remotas desde Git
    flags = [
      "--no-write-lock-file" # Evita que intente escribir el lockfile en el repositorio remoto
      "-L"                    # Muestra los logs de compilación en el journal
    ];

    # Frecuencia (todos los días a las 4:00 AM)
    dates = "04:00";

    # Retraso aleatorio para evitar picos
    randomizedDelaySec = "45min";
  };
}
