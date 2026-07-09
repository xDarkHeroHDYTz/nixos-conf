{
  description = "NixOS de Lisandro";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-millennium = {
      url = "github:re1n0/nixos-millennium";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, noctalia, ... }:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        pkgs-stable = import inputs.nixpkgs-stable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./hosts/configuration.nix
        {
          nixpkgs.overlays = [
            inputs.nix-cachyos-kernel.overlays.default
          ];
        }
        inputs.nixos-millennium.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
              pkgs-stable = import inputs.nixpkgs-stable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
            users.lisandro = import ./hosts/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
