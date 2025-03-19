{
  description = "Development shell with C";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # This is the list of architectures that work with this project
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          pkgs,
          ...
        }:
        {
          # devShells.default describes the default shell with C++, cmake, boost,
          # and catch2
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # C++ Compiler is already part of stdenv
              gcc
              gdb
              cmake
              pkg-config
              valgrind
              zsh
            ];
            shellHook = ''
              export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/:$LD_LIBRARY_PATH";
              export SHELL=$(which zsh);
              echo "Welcome to the C development shell!";
              exec $SHELL;
            '';
          };
        };
    };
}
