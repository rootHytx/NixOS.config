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
        (pkgs.callPackage ./zed-discord-presence.nix { })
        alacritty
        caido
        google-chrome
        cheese
        cosmic-icons
        eog
        fastfetch
        gimp
        inputs.nixd.packages."${pkgs.system}".nixd
        inputs.nixfmt.packages."${pkgs.system}".nixfmt
        (lutris.override {
          extraLibraries = pkgs: [
            # List library dependencies here
          ];
        })
        markdown-oxide
        mission-center
        nwg-look
        gnome-calculator
        ghidra-bin
        libgphoto2
        libreoffice-qt
        libreswan
        love
        nix-index
        nix-search-cli
        nmap
        obsidian
        openssl
        openvpn
        package-version-server
        papers
        popsicle
        pptp
        qbittorrent
        qt6.full
        rofi
        rust-analyzer
        rustc
        rustfmt
        spotify
        stremio
        sublime4
        texlab
        texliveFull
        thefuck
        thunderbird
        unzip
        vagrant
        vesktop
        vlc
        waybar
        wineWowPackages.stable
        zed-editor
        zip
      ];
    };
  };
}
