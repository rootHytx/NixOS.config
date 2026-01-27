{ config, ... }:

{
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
    flatpak.enable = true;
    fprintd = {
      enable = true;
    };
    logind = {
      settings.Login.HandleLidSwitch = "suspend";
    };
    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = true; # Enable the OpenSSH server
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    openvpn = {
      servers = {
        inesc = {
          config = config.INESCTECVPNConfig;
          autoStart = false;
          updateResolvConf = true;
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    power-profiles-daemon.enable = false;
    printing.enable = true;
    pulseaudio.enable = false;
    supergfxd.enable = true;
    system76-scheduler.enable = true;
    tailscale = {
      enable = true;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 0;
      };
    };
    tumbler.enable = true;
  };
}
