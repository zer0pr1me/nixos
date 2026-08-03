{
  description = "Universal Multi-Host NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }: {
    nixosConfigurations = {
      
      vivobook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/vivobook/config.nix
          ./hosts/vivobook/hardware.nix
          niri.nixosModules.niri
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
        modules = [
          ./hosts/latitude/config.nix
          {
            targets.genericLinux.enable = true;
          }
        ];
      };
    };
  };
}
