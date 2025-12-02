{ ... }:

{
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    fprintd = {
      enable = true;
    };
    logind = {
      settings.Login.HandleLidSwitch = "suspend";
    };
    gnome.gnome-keyring.enable = true;
    lorri.enable = true;
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
    tumbler.enable = true;
    power-profiles-daemon.enable = true;
    auto-cpufreq = {
      enable = false;
      settings = {
        battery = {
          governor = "performance";
          turbo = "auto";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    xserver = {
      enable = true;
      dpi = 130;
      upscaleDefaultCursor = true;
      xkb = {
        layout = "pt";
        variant = "";
      };
      #displayManager.gdm.enable = false;
      #desktopManager.gnome.enable = false;
    };
  };
}
