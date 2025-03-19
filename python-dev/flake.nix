{
  description = "Development shell with Python";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs }:
    {
      devShells.default = nixpkgs.lib.mkShell {
        packages = with nixpkgs; [
          python3
          python3Packages.pip
          python3Packages.virtualenv
          zsh
        ];

        shellHook = ''
          export SHELL=$(which zsh)
          echo "Welcome to the Python development shell!"
          exec $SHELL
        '';
      };
    };
}
