{ config, pkgs, lib, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./security_tools.nix
      ./macros.nix
      ./wrapper.nix
      ./fonts.nix
      ./paths.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; 

  services.getty.autologinUser = "hytx";
  programs.hyprland.enable = true;
  programs.nm-applet.enable = true;
  services.blueman.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  fonts.fontconfig.enable = true;

  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  users.users.hytx = {
    isNormalUser = true;
    description = "hytx";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      alacritty betterdiscordctl blueman bluez brightnessctl
      discord feh firefox git glib gnome.nautilus go grim gtk3 hyprlock
      hyprpaper jdk jre neofetch networkmanagerapplet ntfs3g nwg-look
      pavucontrol pipewire python3 qt6.full rofi-wayland slurp
      spotify sublime4 thunderbird waybar wireplumber wl-clipboard
      xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xwaylandvideobridge
    ];
  };
  services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

         #Optional helps save long term battery health
         START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
         STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

        };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11"; # Did you read the comment?

}
