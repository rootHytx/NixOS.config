{ pkgs, ... }:
let
  overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));
  libPath =
    with pkgs;
    lib.makeLibraryPath [
      # load external libraries that you need in your rust project here
    ];
in
{
  environment = {
    systemPackages = with pkgs; [
      btop
      cargo
      clang
      file
      gcc
      git
      glib
      go
      gparted
      home-manager
      jdk
      jre
      libinput
      libudev-zero
      llvmPackages_19.bintools
      mold
      ntfs3g
      openvpn
      pkg-config
      gnomeExtensions.dash-to-dock
      gnomeExtensions.hide-top-bar
      gnomeExtensions.forge
      gnomeExtensions.workspace-indicator
      gnomeExtensions.unite-shell
      gnomeExtensions.undecorate
      gnomeExtensions.pop-shell
      gnome-tweaks
      protobuf_25
      python3
      #qemu
      #quickemu
      rustup
      wireguard-go
      wireguard-tools
      xdg-desktop-portal-cosmic
      xidlehook
      zlib
    ];
    etc = with pkgs; {
      "jdk".source = jdk;
      "jdk8".source = jdk8;
    };
    shellInit = ''

    '';
    sessionVariables = {
      # Add glibc, clang, glib, and other headers to bindgen search path
      # https://github.com/rust-lang/rust-bindgen#environment-variables
      BINDGEN_EXTRA_CLANG_ARGS =
        # Includes normal include path

        (builtins.map (a: ''-I"${a}/include"'') [
          # add dev libraries here (e.g. pkgs.libvmi.dev)
          pkgs.glibc.dev
        ])
        # Includes with special directory paths
        ++ [
          ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
          ''-I"${pkgs.glib.dev}/include/glib-2.0"''
          ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
        ];
      CLUTTER_BACKEND = "wayland";
      COSMIC_DATA_CONTROL_ENABLED = 1;
      DEEPSEEK_API_KEY = "sk-254330fd345b4b4c9c3f262db15f87ed";
      GDK_DPI_SCALE = "0.8";
      GDK_SCALE = "1";
      LD_LIBRARY_PATH = libPath;
      LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
      QT_AUTO_SCREEN_SCALE_FACTOR = "0.8";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "0.8";
      RUSTC_VERSION = overrides.toolchain.channel;
      RUSTFLAGS = (
        builtins.map (a: ''-L ${a}/lib'') [
          # add libraries here (e.g. pkgs.libvmi)
        ]
      );
      STEAM_COMPAT_RUNTIME_SDL2 = 1;
      XCURSOR_SIZE = 24;
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_SESSION_TYPE = "wayland";
      _JAVA_AWT_WM_NONEREPARENTING = "0.8";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=0.8";
    };
  };
}
