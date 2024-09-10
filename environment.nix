{config, pkgs, lib, inputs, ...}:

{
  environment = {
    systemPackages = with pkgs; [
      alacritty
      btop
      dunst
      elvish
      git
      glib
      go
      gparted
      home-manager
      iio-sensor-proxy
      jdk
      jre
      libclang
      libgcc
      libinput
      neovim
      ntfs3g
      python3
      qemu
      quickemu
      sof-firmware
    ];
    etc = with pkgs; {
      "jdk".source = jdk;
      "jdk8".source = jdk8;
    };
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
      XDG_RUNTIME_DIR="/tmp/users/$(id -u)";
      QT_AUTO_SCREEN_SCALE_FACTOR="1";
      QT_QPA_PLATFORM="wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
      SDL_VIDEODRIVER="wayland";
      _JAVA_AWT_WM_NONEREPARENTING="1";
      CLUTTER_BACKEND="wayland";
      _JAVA_AWT_WM_NONREPARENTING="1";
    };
  };
}
