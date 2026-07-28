{
  description = "NixOS Flake Configuration";

  inputs = {
    # Використовуємо стабільну гілку NixOS (наприклад, nixos-unstable або вашу версію)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Необов'язково: офіційний модуль niri
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, niri, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          
          niri.nixosModules.niri
        ];
      };
    };
  };
}
