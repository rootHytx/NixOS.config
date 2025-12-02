{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixd.url = "github:nix-community/nixd/main";
    nixfmt.url = "github:NixOS/nixfmt/master";
    nixos-cosmic = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lilyinstarlight/nixos-cosmic";
    };
    xdg-desktop-portal-cosmic = {
      url = "github:pop-os/xdg-desktop-portal-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #zed-editor.url = "github:zed-industries/zed/1f40a3c"; # last stable version
    #zed-editor.url = "github:zed-industries/zed/main"; # LTS/Unstable
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-cosmic,
      #zed-editor,
      ...
    }:
    let
      system = "x86_64-linux";
      default = import nixpkgs {
        inherit system;
        overlays = [
          #(import ./overlays/cosmic-hashes.nix)
          #zed-editor.overlays.default
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
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                (self: super: {
                  python314 = super.python314.override {
                    packageOverrides = self: super: {
                      pytest-mock = super.pytest-mock.overridePythonAttrs (old: {
                        doCheck = false;
                      });
                      hypothesis = super.hypothesis.overridePythonAttrs (old: {
                        doCheck = false;
                      });
                    };
                  };
                })
                #zed-editor.overlays.default
              ];
              environment.systemPackages = [
                pkgs.zed-editor
              ];
            }
          )
          ./configuration.nix
          ./fonts.nix
          ./hardware-configuration.nix
          {
            nix.settings = {
              substituters = [
                "https://cosmic.cachix.org/"
              ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              ];

            };
          }
          nixos-cosmic.nixosModules.default
          home-manager.nixosModules.home-manager
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
