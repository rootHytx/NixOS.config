{
  pkgs,
  inputs,
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
      (pkgs.writeScriptBin "ns" ''
        #!/usr/bin/env zsh

        if [ $# -eq 0 ]; then
          echo "Usage: ns <package-name>"
          echo "Example: ns dnslookup"
          exit 1
        fi

        exec nix shell nixpkgs#"$1" --set-env-var IN_NIX_SHELL 1
      '')
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
      unset SOURCE_DATE_EPOCH
      export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH
      export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
      export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin
      export PROTOC=${pkgs.protobuf_25}/bin/protoc
      if [ -f /run/secrets/DEEPSEEK_API_KEY ]; then
        export DEEPSEEK_API_KEY="$(cat /run/secrets/DEEPSEEK_API_KEY)"
      fi
      if [ -f /run/secrets/XSTF_CTFD_TOKEN ]; then
        export XSTF_CTFD_TOKEN="$(cat /run/secrets/XSTF_CTFD_TOKEN)"
      fi
      if [ -f /run/secrets/XSTF_CTFD_URL ]; then
        export XSTF_CTFD_URL="$(cat /run/secrets/XSTF_CTFD_URL)"
      fi
      if [ -f /run/secrets/XSTF_CTFD_DEPLOY_HOST ]; then
        export XSTF_CTFD_DEPLOY_HOST="$(cat /run/secrets/XSTF_CTFD_DEPLOY_HOST)"
      fi
      if [ -f /run/secrets/INESC_VPN_CREDS ]; then
        export INESC_VPN_CREDS="$(cat /run/secrets/INESC_VPN_CREDS)"
      fi

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
      DEFAULT_BROWSER = "${
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      }/bin/zen";
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
