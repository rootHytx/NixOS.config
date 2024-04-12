{ config, pkgs, lib, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  
  services.blueman.enable = true;
  services.xserver.enable = false;
  #services.xserver.displayManager.autoLogin.user = "hytx";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  services.getty.autologinUser = "hytx";
  services.xserver.wacom.enable = true;
  services.tumbler.enable = true; # Thumbnail support for images
   services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=suspend
    HandleLidSwitch=suspend
  '';
  services.udev.enable=true;
  services.udev.extraHwdb = ''
    sensor:modalias:acpi:INVN6500*:dmi:*svn*ASUSTeK*:*pn*TP300LA*
     ACCEL_MOUNT_MATRIX=0, 1, 0; 1, 0, 0; 0, 0, 1
  '';
  networking.hostName = "nixos"; # Define your hostname.  
  networking.networkmanager.enable = true;
  fonts.fontconfig.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; 
  hardware.pulseaudio.enable = false;
  hardware.sensor.iio.enable = true;
  powerManagement.powertop.enable = true;
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; 
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
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
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

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
        git alacritty glib go jdk jre pipewire
        libclang libgcc ntfs3g python3 btop
        catppuccin-gtk wireplumber home-manager
        gparted iio-sensor-proxy libinput elvish 
        neovim
  ];
  environment.etc = with pkgs; {
    "jdk".source = jdk;
    "jdk8".source = jdk8;
  };

  environment.sessionVariables = {
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

  users.users = {
    hytx = {
      isNormalUser = true;
      shell=pkgs.elvish;
      extraGroups = [ "networkmanager" "wheel" "docker" "vbox" ];
      packages = with pkgs; [
        betterdiscordctl blueman bluez brightnessctl chromium discord
        docker fastfetch feh firefox grim inputs.hyprlock.packages."${pkgs.system}".hyprlock 
        hyprpaper networkmanagerapplet openvpn pavucontrol qt6.full rofi-wayland
        rustup slurp spotify sublime4 thunderbird waybar wl-clipboard
        xdg-desktop-portal-hyprland xournalpp xwaylandvideobridge
        stremio loupe vlc gimp  wvkbd nwg-look runescape jetbrains-toolbox
        libreoffice-qt
      ];
    };
  };
  virtualisation.docker.enable = true;


  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "vbox" ];
  
  system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--no-write-lock-file"
        "-L" # print build logs
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w"];

  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade.allowReboot  = false;

}
