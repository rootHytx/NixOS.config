{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
         url = "github:nix-community/home-manager/release-23.11";
         # The `follows` keyword in inputs is used for inheritance.
         # Here, `inputs.nixpkgs` of home-manager is kept consistent with
         # the `inputs.nixpkgs` of the current flake,
         # to avoid problems caused by different versions of nixpkgs.
         inputs.nixpkgs.follows = "nixpkgs";
       };
    hyprlock.url = "github:hyprwm/hyprlock/main";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./security_tools.nix
        ./wrapper.nix
        ./fonts.nix
        ./paths.nix
        ./macros.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hytx = import ./home.nix;
        }
        # This module works the same as the `specialArgs` parameter we used above
        # chose one of the two methods to use
        # { _module.args = { inherit inputs; };}
      ];
    };
  };
}