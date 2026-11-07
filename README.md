cp /etc/nixos/hardware-configuration.nix ~/.nixos-conf/hosts/{$hostname}/hardware-configuration.nix

nix-shell -p git

sudo nixos-rebuild switch --flake ~/.nixos-conf#{$hostname}

age keys y quitar llaves personales.

cambiar nombre de usuario lisandro por el deseado

nix-shell -p sbctl

sudo sbctl create-keys

sudo sbctl enroll-keys --microsoft
