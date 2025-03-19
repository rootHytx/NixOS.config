{
  description = "Development shell with Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      ...
    }:
    let
      rust-toolchain = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/rootHytx/NixOS.config/refs/heads/main/rust-toolchain.toml";
        sha256 = "sha256:0yfl6i9mc7jpxwx50qxag1kynwcmv0yfic6adz7cxl4l8n7vxsll";
      };
    in
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
        let
          libPath = pkgs.lib.makeLibraryPath [
            # load external libraries that you need in your rust project here
          ];
          overrides = builtins.fromTOML (builtins.readFile "${rust-toolchain}");
        in
        {
          devShells.default = pkgs.mkShell {

            buildInputs = with pkgs; [
              clang
              cargo
              rustup
              llvmPackages_20.bintools
              protobuf_25
            ];
            RUSTC_VERSION = overrides.toolchain.channel;
            LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
            shellHook = ''
              export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
              export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin
              export PROTOC=${pkgs.protobuf_28}/bin/protoc
            '';
            RUSTFLAGS = builtins.map (a: ''-L ${a}/lib'') [
              # add libraries here (e.g. pkgs.libvmi)
            ];
            LD_LIBRARY_PATH = libPath;
            BINDGEN_EXTRA_CLANG_ARGS =
              (builtins.map (a: ''-I"${a}/include"'') [
                # add dev libraries here (e.g. pkgs.libvmi.dev)
                pkgs.glibc.dev
              ])
              ++ [
                ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
                ''-I"${pkgs.glib.dev}/include/glib-2.0"''
                ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
              ];
          };
        };
    };
}
