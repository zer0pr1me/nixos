{
  description = "Universal Multi-Host NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, niri, ... }: {
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
  };
}
