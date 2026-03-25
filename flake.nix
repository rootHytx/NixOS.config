{
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/5b2c2d84341b2afb5647081c1386a80d7a8d8605"; # REGRESSION: duplicate dbus-settings-bindings source in cosmic-settings-daemon's vendor archive
    nixd.url = "github:nix-community/nixd/main";
    nixfmt.url = "github:NixOS/nixfmt/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      default = import nixpkgs {
        inherit system;
        overlays = [
        ];
      };
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit default;
        };
        modules = [
          ./configuration.nix
          ./fonts.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hytx = import ./home.nix;
            home-manager.extraSpecialArgs = {
              inherit default;
            };
          }
        ];
      };
    };
}
