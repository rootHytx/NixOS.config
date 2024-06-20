{config, pkgs, lib, inputs, ...}:

{
    services = {
    blueman.enable = true;
    xserver = {
      enable = true;
      wacom.enable = true;
      windowManager.i3.enable=true;
      displayManager.lightdm = {
        enable = true;
        greeters.tiny.enable = true;
      };
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "hytx";
      };
      defaultSession = "hyprland";
    };
    tumbler.enable = true;
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
      HandleLidSwitch=suspend
    '';
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = false;
    };
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable=true;
    };
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        STOP_CHARGE_THRESH_BAT0=1; # 59 and above it stops charging
      };
    };
    openssh = {
      enable = true;
    };
    zerotierone = {
      enable = true;
      joinNetworks = [ "73a15e146065937a" ];
    };
  };
}
