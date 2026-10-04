{ pkgs, ... }:

let
  creamlinux = import (pkgs.fetchFromGitHub {
    owner = "Novattz";
    repo = "creamlinux-installer";
    rev = "main"; # O un commit específico para fijar la versión
    hash = "";   # Déjalo vacío al inicio
  }) { inherit pkgs; };
in
{
  environment.systemPackages = [
    creamlinux
  ];
}
