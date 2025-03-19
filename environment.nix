{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      btop
      file
      git
      go
      gparted
      home-manager
      jdk
      jre
      libinput
      libudev-zero
      ntfs3g
      openvpn
      pkg-config
      gnome-tweaks
      python3Full
      xdg-desktop-portal-cosmic
      zlib
    ];
    etc = with pkgs; {
      "jdk".source = jdk;
      "jdk8".source = jdk8;
    };
    shellInit = ''

    '';
    sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      COSMIC_DATA_CONTROL_ENABLED = 1;
      NIXPKGS_ALLOW_UNFREE = "1";
      GDK_DPI_SCALE = "0.8";
      GDK_THEME = "COSMIC";
      GDK_SCALE = "1";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "0.8";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "0.8";
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
