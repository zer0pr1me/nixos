{
  description = "Universal Multi-Host NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anamnesis = {
      url = "git+https://codeberg.org/zer0pr1me/anamnesis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      niri,
      nixgl,
      anamnesis,
      ...
    }:
    {
      nixosConfigurations = {

        vivobook = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            currentHost = "vivobook";
          };
          modules = [
            ./modules/common.nix
            ./hosts/vivobook/config.nix
            ./hosts/vivobook/hardware.nix
            niri.nixosModules.niri

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = {
                currentHost = "vivobook";
              };
              home-manager.users.alice = ./users/alice.nix;
            }
          ];
        };

        zeroprime-cc = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            currentHost = "zeroprime-cc";
          };
          modules = [
            ./modules/common.nix
            ./hosts/cc/config.nix
            ./hosts/cc/hardware.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = {
                currentHost = "zeroprime-cc";
                inherit anamnesis;
              };
              home-manager.users.bob = ./users/bob.nix;
            }
          ];
        };

      };

      homeConfigurations = {
        "latitude" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit nixgl;
            currentHost = "latitude";
          };
          modules = [
            niri.homeModules.niri
            ./hosts/latitude/config.nix
            ./users/bohdan.nix
            {
              targets.genericLinux.enable = true;
              home.packages = [ nixgl.packages.x86_64-linux.nixGLIntel ]; # or nixGLNvidia / nixVulkan
            }
          ];
        };
      };
    };
}
