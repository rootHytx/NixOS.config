{config, pkgs, lib, inputs, ...}:

{  
  users.users = {
    hytx = {
      isNormalUser = true;
      shell=pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" ];
      packages = with pkgs; [
        catppuccin-gtk
        colloid-icon-theme
        betterdiscordctl
        blueman
        bluez
        brightnessctl
        chromium
        discord
        docker
        fastfetch
        feh
        file
        font-awesome
        gimp
        ghidra
        grim
        inputs.hyprpaper.packages."${pkgs.system}".hyprpaper
        #hyprpaper
        inputs.hyprlock.packages."${pkgs.system}".hyprlock
        jetbrains-toolbox
        libreoffice-qt
        libreswan
        loupe
        lsof
        networkmanagerapplet
        nwg-look
        nmap
        nodejs_22
        openvpn
        pavucontrol
        playerctl
        protobuf_25
        qt6.full
        rofi-wayland
        rustup
        slurp
        spotify
        stremio
        sublime4
        thefuck
        thunderbird
        unzip
        vlc
        waybar
        webcord
        wl-clipboard
        wvkbd
        xdg-desktop-portal-hyprland
        xournalpp
        xwaylandvideobridge
      ];
    };
  };
}
