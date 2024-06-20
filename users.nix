{config, pkgs, lib, inputs, ...}:

{
  users.users = {
    hytx = {
      isNormalUser = true;
      shell=pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "docker" "vbox" ];
      packages = with pkgs; [
        betterdiscordctl
        blueman
        bluez
        brightnessctl
        chromium
        discord
        docker
        fastfetch
        feh
        firefox
        font-awesome
        gimp
        grim
        #inputs.hyprpaper.packages."${pkgs.system}".hyprpaper
        hyprpaper
        inputs.hyprlock.packages."${pkgs.system}".hyprlock
        jetbrains-toolbox
        libreoffice-qt
        libreswan
        loupe
        networkmanagerapplet
        nwg-look
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
