{
  pkgs,
  inputs,
  ...
}:

{
  users.extraGroups.vboxusers.members = [ "hytx" ];
  users.users = {
    hytx = {
      name = "hytx";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "vboxuser"
      ];
      packages = with pkgs; [
        alacritty
        cosmic-icons
        eog
        fastfetch
        firefox
        gimp
        (lutris.override {
          extraLibraries = pkgs: [
            # List library dependencies here
          ];
        })
        markdown-oxide
        inputs.nixd.packages."${pkgs.system}".nixd
        inputs.nixfmt.packages."${pkgs.system}".nixfmt
        #inputs.zed-editor.packages."${pkgs.system}".zed-editor
        zed-editor
        geoclue2
        gnome-calculator
        gnome-multi-writer
        #ghidra
        libreoffice-qt
        libreswan
        love
        nix-index
        nmap
        nodejs_22
        openssl
        openvpn
        papers
        pptp
        qbittorrent
        qt6.full
        rofi
        rust-analyzer
        rustc
        rustfmt
        spice-gtk
        spotify
        stremio
        sublime4
        texlab
        texliveFull
        thefuck
        thunderbird
        unzip
        vesktop
        vlc
        waybar
        wineWowPackages.stable
        zerotierone
        zip
      ];
    };
  };
}
