{
  pkgs,
  inputs,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    "browser.ml.enable" = false;
    "browser.preferences.experimental.hidden" = false;
    "browser.theme.windows.accent-color-in-tabs.enabled" = true;
    "browser.toolbars.bookmarks.visibility" = "always";
    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "Google";
    "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
    "devtools.chrome.enabled" = true;
    "devtools.debugger.remote-enabled" = true;
    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    "extensions.webcompat.enable_interventions" = true;
    "extensions.webcompat.enable_shims" = true;
    "extensions.webcompat.perform_injections" = true;
    "extensions.webcompat.perform_ua_overrides" = true;
    "privacy.clearOnShutdown_v2.formdata" = true;
    "privacy.globalprivacycontrol.was_ever_enabled" = true;
    "privacy.history.custom" = true;
    "sidebar.visibility" = "hide-sidebar";
    "signon.rememberSignons" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "zen.theme.accent-color" = "#c100fc";
    "zen.theme.color-prefs.colorful" = true;
    "zen.theme.content-element-separation" = 16;
    "zen.theme.gradient.show-custom-colors" = true;
    "zen.ui.migration.compact-mode-button-added" = true;
    "zen.view.compact" = true;
    "zen.view.compact.enable-at-startup" = false;
    "zen.view.use-single-toolbar" = false;
    "zen.watermark.enabled" = false;
    "zen.welcome-screen.seen" = true;
    "zen.welcomeScreen.seen" = true;
    "zen.widget.linux.transparency" = true;
    "zen.workspaces.continue-where-left-off" = true;
    "zen.workspaces.separate-essentials" = true;
  };

  extensions = [
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "nordpass-password-management" "nordpassStandalone@nordsecurity.com")
  ];

in
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
      ];
      packages = with pkgs; [
        (lutris.override {
          extraLibraries = pkgs: [
            # List library dependencies here
          ];
        })
        (pkgs.callPackage ./zed-discord-presence.nix { })
        (pkgs.wrapFirefox
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
          {
            extraPrefs = lib.concatLines (
              lib.mapAttrsToList (
                name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
              ) prefs
            );

            extraPolicies = {
              DisableTelemetry = true;
              ExtensionSettings = builtins.listToAttrs extensions;

              SearchEngines = {
                Default = "ddg";
                Add = [
                  {
                    Name = "nixpkgs packages";
                    URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@np";
                  }
                  {
                    Name = "NixOS options";
                    URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@no";
                  }
                  {
                    Name = "NixOS Wiki";
                    URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@nw";
                  }
                  {
                    Name = "noogle";
                    URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                    IconURL = "https://noogle.dev/favicon.ico";
                    Alias = "@ng";
                  }
                ];
              };
            };
          }
        )
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
        flatpak
        gdb
        ghidra-bin
        gimp
        gnome-calculator
        go
        guvcview
        inputs.nixd.packages."${pkgs.stdenv.hostPlatform.system}".nixd
        inputs.nixfmt.packages."${pkgs.stdenv.hostPlatform.system}".nixfmt
        jdk
        jre
        kubernetes
        libffi
        libgphoto2
        libreoffice
        llvmPackages_20.bintools
        love
        markdown-oxide
        mattermost-desktop
        mission-center
        neofetch
        nix-index
        nix-search-cli
        nmap
        nwg-look
        obsidian
        onionshare-gui
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
        rust-bindgen
        rustfmt
        rustup
        spotify
        spicetify-cli
        steam-run
        #stremio
        swig
        texlab
        thunderbird
        tor-browser
        unzip
        uv
        valgrind
        vesktop
        vlc
        wineWowPackages.stable
        zip
        zed-editor
      ];

    };
  };
}
