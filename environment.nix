{
  pkgs,
  config,
  ...
}:
let
  overrides = (fromTOML (builtins.readFile ./rust-toolchain.toml));
in
{
  environment = {
    systemPackages = with pkgs; [
      btop
      direnv
      file
      git
      gparted
      home-manager
      libinput
      libudev-zero
      ntfs3g
      openvpn
      gnome-tweaks
      qemu_full
      quickemu
      zlib
    ];
    etc = with pkgs; {
      "jdk".source = jdk;
      "jdk8".source = jdk8;
      "qemu/bridge.conf".text = ''
        allow br0
      '';
    };
    shellInit = ''
      export PYTHONPATH=/home/hytx/venv/${pkgs.python3.sitePackages}:$PYTHONPATH
      #export PATH=/home/hytx/venv/bin:$PATH
      unset SOURCE_DATE_EPOCH
      export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH
      export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
      export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin
      export PROTOC=${pkgs.protobuf_25}/bin/protoc
    '';

    sessionVariables = {
      NIX_SHELL = "zsh -i";
      RUSTFLAGS = [ ];
      BINDGEN_EXTRA_CLANG_ARGS = [
        "-I${pkgs.glibc.dev}/include"
        "-I${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"
        "-I${pkgs.glib.dev}/include/glib-2.0"
        "-I${pkgs.glib.out}/lib/glib-2.0/include"
      ];
      RUSTC_VERSION = overrides.toolchain.channel;
      LIBCLANG_PATH = with pkgs; lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
      CLUTTER_BACKEND = "wayland";
      COSMIC_DATA_CONTROL_ENABLED = 1;
      DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
      FASTFETCH_NIXOS_GENERATION = "$(basename $(readlink /nix/var/nix/profiles/system) | cut -d- -f2)";
      NIXPKGS_ALLOW_UNFREE = "1";
      GDK_DPI_SCALE = "1";
      GDK_THEME = "COSMIC";
      GDK_SCALE = "1.75";
      JAVA_TOOL_OPTIONS = [ "-Dsun.java2d.uiScale=1.75" ];
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      STEAM_COMPAT_RUNTIME_SDL2 = 1;
      XCURSOR_SIZE = 24;
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      DEEPSEEK_API_KEY = builtins.readFile config.sops.secrets.deepseekAPIKey.path;
      CTFD_TOKEN = builtins.readFile config.sops.secrets.xSTFCTFDToken.path;
      CTFD_URL = builtins.readFile config.sops.secrets.xSTFCTFDURL.path;
      DEPLOY_HOST = builtins.readFile config.sops.secrets.xSTFCTFDDeployHost.path;
      XDG_SESSION_TYPE = "wayland";
      WLR_DRM_NO_ATOMIC = "1";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      _JAVA_OPTIONS = [
        "-Dsun.java2d.uiScale=1.75"
        #"-Dsun.java2d.dpiaware=true"
      ];
    };
  };
}
