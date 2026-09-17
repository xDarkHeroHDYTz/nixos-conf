{
  description = "NixOS de Lisandro";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    low-latency-layer = {
      url = "github:nmetschke/nixos-low-latency-layer?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-millennium = {
      url = "github:re1n0/nixos-millennium";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    mkSystem = configurationPath: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs pkgs-stable;
      };
      modules = [
        { nixpkgs.hostPlatform = system; }
        configurationPath
        {
          nixpkgs.overlays = [
            inputs.nix-cachyos-kernel.overlays.pinned
          ];
        }
        inputs.stylix.nixosModules.stylix
        inputs.nixos-millennium.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = {
              inherit inputs pkgs-stable;
            };
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      pc = mkSystem ./hosts/pc/configuration.nix;
      laptop = mkSystem ./hosts/laptop/configuration.nix;
      default = self.nixosConfigurations.pc;
    };
  };
}
