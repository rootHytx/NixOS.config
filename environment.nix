{pkgs, ...}:

{
  environment = {
    systemPackages = with pkgs; [
      btop
      clang
      file
      git
      glib
      go
      gparted
      home-manager
      jdk
      jre
      libclang
      libgcc
      libinput
      libudev-zero
      llvmPackages_17.bintools
      ntfs3g
      openvpn
      pkg-config
      protobuf_25
      python3
      qemu
      quickemu
      rustup
    ];
    etc = with pkgs; {
      "jdk".source = jdk;
      "jdk8".source = jdk8;
    };
    sessionVariables = {
      RUSTC_VERSION = pkgs.lib.readFile ./rust-toolchain;
      LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
      RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
      ]);
      BINDGEN_EXTRA_CLANG_ARGS =
      (builtins.map (a: ''-I"${a}/include"'') [
      pkgs.glibc.dev
      ])
          ++ [
          ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
          ''-I"${pkgs.glib.dev}/include/glib-2.0"''
          ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
          ];
      XDG_CONFIG_HOME = "$HOME/.config";
      _JAVA_AWT_WM_NONEREPARENTING="1";
      CLUTTER_BACKEND="wayland";
      _JAVA_AWT_WM_NONREPARENTING="1";
    };
    plasma6.excludePackages = with pkgs.kdePackages; [
  	konsole
  	elisa
    ];
  };
}
