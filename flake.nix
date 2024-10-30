{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zed-editor.url = "github:zed-industries/zed/main";
    nixd.url = "github:nix-community/nixd/main";
    home-manager = {
         url = "github:nix-community/home-manager";
         # The `follows` keyword in inputs is used for inheritance.
         # Here, `inputs.nixpkgs` of home-manager is kept consistent with
         # the `inputs.nixpkgs` of the current flake,
         # to avoid problems caused by different versions of nixpkgs.
         inputs.nixpkgs.follows = "nixpkgs";
       };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system="x86_64-linux";
      default=import nixpkgs {inherit system;};
    in
  {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; inherit default; };
      modules = [
        ./configuration.nix
        ./fonts.nix
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.hytx = import ./home.nix;
          home-manager.extraSpecialArgs = {inherit default;};
        }
        # This module works the same as the `specialArgs` parameter we used above
        # chose one of the two methods to use
        # { _module.args = { inherit inputs; };}
      ];
    };
  };
}
