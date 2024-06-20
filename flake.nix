{
  inputs = {
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
         url = "github:nix-community/home-manager";
         # The `follows` keyword in inputs is used for inheritance.
         # Here, `inputs.nixpkgs` of home-manager is kept consistent with
         # the `inputs.nixpkgs` of the current flake,
         # to avoid problems caused by different versions of nixpkgs.
         inputs.nixpkgs.follows = "nixpkgs";
       };
    hyprlock.url = "github:hyprwm/hyprlock/main";
    hyprpaper.url = "github:hyprwm/hyprpaper/main";
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
        ./boot.nix
        ./configuration.nix
        ./environment.nix
        ./fonts.nix
        ./hardware.nix
        ./hardware-configuration.nix
        ./i18n.nix
        ./networking.nix
        ./programs.nix
        ./services.nix
        ./users.nix
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
