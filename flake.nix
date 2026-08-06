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

  };

  outputs = { self, nixpkgs, home-manager, niri, nixgl, ... }: {
    nixosConfigurations = {
      
      vivobook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
            home-manager.users.alice = import ./users/alice.nix;
          }
        ];
      };

      cc = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/cc/config.nix
          ./hosts/cc/hardware.nix
        ];
      };

    };

    homeConfigurations = {
      "latitude" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit nixgl; };
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
