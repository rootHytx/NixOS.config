{
  pkgs,
  inputs,
  ...
}:

{
  users.groups.libvirtd.members = [ "hytx" ];
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
        "libvirtd"
        "openrazer"
      ];
      packages = with pkgs; [
        (lutris.override {
          extraLibraries = pkgs: [
            # List library dependencies here
          ];
        })
        (pkgs.callPackage ./zed-discord-presence.nix { })
        alacritty
        brave
        caido
        cargo
        cheese
        clang
        cmake
        cosmic-icons
        eog
        exfatprogs
        fastfetch
        ffmpegthumbnailer
        gdb
        ghidra-bin
        gimp
        gnome-calculator
        go
        guvcview
        inputs.nixd.packages."${pkgs.system}".nixd
        inputs.nixfmt.packages."${pkgs.system}".nixfmt
        jdk
        jre
        kubernetes
        libffi
        libgphoto2
        libreoffice-qt
        #libreswan
        llvmPackages_20.bintools
        love
        markdown-oxide
        mattermost-desktop
        mission-center
        neofetch
        nextcloud-client
        nix-index
        nix-search-cli
        nmap
        nordpass
        nwg-look
        obsidian
        onionshare-gui
        openssl
        openssl
        openvpn
        package-version-server
        papers
        pkg-config
        popsicle
        pptp
        protobuf_25
        python315
        python3Packages.distutils
        python3Packages.flask
        python3Packages.mock
        python3Packages.numpy
        python3Packages.pandas
        python3Packages.pip
        python3Packages.pwntools
        python3Packages.torch
        python3Packages.python-dotenv
        python3Packages.opencv-python
        qbittorrent
        rofi
        ruby
        rust-analyzer
        rustc
        rustfmt
        rustup
        spotify
        spicetify-cli
        steam-run
        (stremio.override {
          nodejs = pkgs.nodejs_20;
        })
        swig
        texlab
        thunderbird
        tmux
        tor-browser
        unzip
        vagrant
        valgrind
        vesktop
        vlc
        waybar
        wineWowPackages.stable
        zip
        zed-editor
      ];

    };
  };
}
