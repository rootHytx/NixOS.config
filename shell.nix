{ }:
let
  overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));

  # Overlay to disable tests for problematic packages
  myOverlay = self: super: {
    python314 = super.python314.override {
      packageOverrides = self: super: {
        # Disable pytest-mock tests
        pytest-mock = super.pytest-mock.overridePythonAttrs (old: {
          doCheck = false;
        });
        # Disable hypothesis tests
        hypothesis = super.hypothesis.overridePythonAttrs (old: {
          doCheck = false;
        });
      };
    };
  };

  # Import nixpkgs with the overlay
  customPkgs = import <nixpkgs> { overlays = [ myOverlay ]; };

  libPath =
    with customPkgs;
    lib.makeLibraryPath [
      # Add external libraries if needed
    ];
in
customPkgs.mkShell {
  name = "default-dev-environment";
  packages = with customPkgs; [
    neofetch
    cargo
    clang
    cmake
    gcc
    gdb
    go
    jdk
    jre
    libffi
    llvmPackages_20.bintools
    markdown-oxide
    openssl
    package-version-server
    pkg-config
    protobuf_25
    python315
    python3Packages.pwntools
    python3Packages.mock
    python3Packages.numpy
    python3Packages.pandas
    python3Packages.torch
    python3Packages.pip
    python3Packages.distutils
    texlab
    ruby_3_1
    rust-analyzer
    rustc
    rustfmt
    rustup
    swig
    valgrind
    (callPackage ./zed-discord-presence.nix { })
  ];
  RUSTC_VERSION = overrides.toolchain.channel;
  LIBCLANG_PATH = customPkgs.lib.makeLibraryPath [ customPkgs.llvmPackages_latest.libclang.lib ];
  LD_LIBRARY_PATH = libPath;
  shellHook = ''
    export DEVELOPMENT_SHELL=1
    export TERM_PROGRAM=1
    export PYTHONPATH=/home/hytx/venv/${customPkgs.python3.sitePackages}:$PYTHONPATH
    #export PATH=/home/hytx/venv/bin:$PATH
    unset SOURCE_DATE_EPOCH
    export LD_LIBRARY_PATH=${customPkgs.stdenv.cc.cc.lib}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH
    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin
    export PROTOC=${customPkgs.protobuf_28}/bin/protoc
  '';
  RUSTFLAGS = [ ];
  BINDGEN_EXTRA_CLANG_ARGS = [
    "-I${customPkgs.glibc.dev}/include"
    "-I${customPkgs.llvmPackages_latest.libclang.lib}/lib/clang/${customPkgs.llvmPackages_latest.libclang.version}/include"
    "-I${customPkgs.glib.dev}/include/glib-2.0"
    "-I${customPkgs.glib.out}/lib/glib-2.0/include"
  ];
}
