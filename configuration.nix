{ config, pkgs, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  
  services.blueman.enable = true;
  networking.hostName = "nixos"; # Define your hostname.  
  fonts.fontconfig.enable = true;
  services.xserver.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; 
  hardware.pulseaudio.enable = false;
  powerManagement.powertop.enable = true;
  services.getty.autologinUser = "hytx";
  

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

  services.printing.enable = true;

  sound.enable = true;
  security.rtkit.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.nm-applet.enable = true;

  services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "power";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 85;

         #Optional helps save long term battery health
         START_CHARGE_THRESH_BAT = 40; # 40 and bellow it starts to charge
         STOP_CHARGE_THRESH_BAT = 80; # 80 and above it stops charging

        };
  };

  environment.systemPackages = with pkgs; [
        alacritty git glib go jdk jre pipewire
        libclang libgcc ntfs3g python3 btop
        catppuccin-gtk wireplumber home-manager
  ];

  users.users = {
    hytx = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "vbox" ];
      packages = with pkgs; [
        betterdiscordctl blueman bluez brightnessctl
        discord fastfetch feh firefox gnome.nautilus
        grim hyprlock hyprpaper jetbrains.rust-rover
        networkmanagerapplet pavucontrol
        qt6.full rofi-wayland rustup slurp spotify
        sublime4 thunderbird waybar wl-clipboard
        xdg-desktop-portal-hyprland xournalpp xwaylandvideobridge
        chromium docker openvpn
      ];
    };
  };
  virtualisation.docker.enable = true;


  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vbox" ];
  

  programs.hyprland.enable=true;
  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = false;

}
