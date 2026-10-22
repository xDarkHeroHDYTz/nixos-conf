{
  description = "NixOS de Lisandro";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
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

    artcraft = {
      url = "github:Hy4ri/artcraft-flake";
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
            inputs.artcraft.overlays.default
          ];
        }
        inputs.chaotic.nixosModules.default
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
