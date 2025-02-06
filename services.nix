{ ... }:

{
  services = {
    asus-numberpad-driver = {
      enable = true;
      layout = "up5401ea";
      wayland = true;
      runtimeDir = "/run/user/1000/";
      waylandDisplay = "wayland-1";
      config = {
        "activation_time" = "0.5";
        "multitouch" = "1";
        "default_backlight_level" = "0x01";
        "top_left_icon_brightness_func_max_min_only" = "1";
        "top_left_icon_activation_time" = "0.5";
        "top_left_icon_slide_func_activation_radius" = "1200";
        "top_left_icon_slide_func_activates_numpad" = "1";
      };
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    fprintd = {
      enable = true;
    };
    logind = {
      lidSwitch = "suspend";
    };
    openssh = {
      enable = true; # Enable the OpenSSH server
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
    pulseaudio.enable = false;
    supergfxd.enable = true;
    tailscale = {
      enable = true;
    };
    xserver = {
      enable = true;
      dpi = 130;
      upscaleDefaultCursor = true;
      xkb = {
        layout = "pt";
        variant = "";
      };
      displayManager.gdm.enable = false;
      desktopManager.gnome.enable = false;
    };
  };
}
