{ pkgs, default, ... }:
let
  cursorName = "capitaine-cursors";
  cursorPackage = pkgs.capitaine-cursors;
  cursorSize = 24;
  defaultBrowser = "zen.desktop";
  defaultVideoPlayer = "vlc.desktop";
  defaultImageViewer = "org.gnome.eog.desktop";
  defaultTerminal = "Alacritty.desktop";
  defaultEditor = "dev.zed.Zed.desktop";
in
{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home = {
    username = "hytx";
    homeDirectory = "/home/hytx";
    pointerCursor = {
      name = cursorName;
      package = cursorPackage;
      size = cursorSize;
    };
    file.".zprofile".text = ''
      if [ -f /run/secrets/DEEPSEEK_API_KEY ]; then
        export DEEPSEEK_API_KEY="$(cat /run/secrets/DEEPSEEK_API_KEY)"
      fi
      if [ -f /run/secrets/XSTF_CTFD_TOKEN ]; then
        export XSTF_CTFD_TOKEN="$(cat /run/secrets/XSTF_CTFD_TOKEN)"
      fi
      if [ -f /run/secrets/XSTF_CTFD_URL ]; then
        export XSTF_CTFD_URL="$(cat /run/secrets/XSTF_CTFD_URL)"
      fi
      if [ -f /run/secrets/XSTF_CTFD_DEPLOY_HOST ]; then
        export XSTF_CTFD_DEPLOY_HOST="$(cat /run/secrets/XSTF_CTFD_DEPLOY_HOST)"
      fi
      if [ -f /run/secrets/INESC_VPN_CREDS ]; then
        export INESC_VPN_CREDS="$(cat /run/secrets/INESC_VPN_CREDS)"
      fi
    '';
  };
  gtk = {
    enable = true;
    cursorTheme = {
      name = cursorName;
      package = cursorPackage;
      size = cursorSize;
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
  };
  xdg.mimeApps = {
    enable = true;
    associations.removed = { };
    defaultApplications = {
      "x-scheme-handler/http" = defaultBrowser;
      "x-scheme-handler/https" = defaultBrowser;
      "x-scheme-handler/about" = defaultBrowser;
      "x-scheme-handler/unknown" = defaultBrowser;
      "application/pdf" = defaultBrowser;
      "video/x-matroska" = defaultVideoPlayer;
      "video/mp4" = defaultVideoPlayer;
      "video/x-msvideo" = defaultVideoPlayer;
      "video/webm" = defaultVideoPlayer;
      "video/ogg" = defaultVideoPlayer;
      "video/x-flv" = defaultVideoPlayer;
      "image/png" = defaultImageViewer;
      "image/jpeg" = defaultImageViewer;
      "image/jpg" = defaultImageViewer;
      "image/gif" = defaultImageViewer;
      "image/bmp" = defaultImageViewer;
      "image/tiff" = defaultImageViewer;
      "image/webp" = defaultImageViewer;
      "image/x-icon" = defaultImageViewer;
      "image/svg+xml" = defaultImageViewer;
      "x-scheme-handler/terminal" = defaultTerminal;
      "text/plain" = defaultEditor;
      "text/x-csrc" = defaultEditor;
      "text/html" = defaultEditor;
      "text/x-c++src" = defaultEditor;
      "text/x-python" = defaultEditor;
      "text/x-shellscript" = defaultEditor;
      "application/json" = defaultEditor;
      "application/xml" = defaultEditor;
    };
  };
  programs = {
    git = {
      settings = {
        user = {
          email = "up201906931@up.pt";
          name = "hytx";
        };
      };
      enable = true;
      lfs.enable = true;
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks =
        import ./ssh/dcc.nix
        // import ./ssh/inesc.nix
        // import ./ssh/personal.nix
        // import ./ssh/xstf.nix;
    };
    zsh = {
      package = default.zsh;
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        balatro = "love /home/hytx/.local/share/Steam/steamapps/common/Balatro/Balatro.exe";
        clear = "clear ; fastfetch-custom";
        config = "zed /etc/nixos/";
        ctfd = "docker compose -f /home/hytx/Desktop/CYBERSEC/xstf/CTFd-local/docker-compose.yml";
        cyber = "cd /home/hytx/Desktop/CYBERSEC/";
        fastfetch-custom = "fastfetch --config ~/.config/fastfetch/preset1.jsonc";
        minecraft = "nix-shell -p steam --run 'steam-run java -jar /home/hytx/Games/TLauncher/TLauncher.jar'";
        nervctf = "cd '/home/hytx/Desktop/CYBERSEC/tese/NervCTF'";
        nfu = "ulimit -n 4096; prev=$(pwd) ; /etc/nixos ; _ nix flake update ; rebuild ; cd $prev";
        rebuild = "sudo nixos-rebuild switch";
        venv = "source ~/.venv/bin/activate";
        xstf = "cd /home/hytx/Desktop/CYBERSEC/xstf";
        zed = "zeditor";
        zsh-remote = "cd ~/scripts ; ./zsh_remote_install.sh $1 ; cd $prev";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        custom = "$HOME/.config/zsh/";
        theme = "darkblood-custom";
      };

      history.size = 1000000;
      history.path = "/home/hytx/.config/zsh/history";
      initContent = ''
        export ZSH_COMPDUMP=/tmp/.zcompdump-$HOST
        export PATH=$PATH:/home/hytx/go/bin/
        if [[ -n $IN_NIX_SHELL ]]; then
            WHOIS="nix-shell"
        else
            unset TERM_APPEARANCE; fastfetch --config ~/.config/fastfetch/preset1.jsonc
        fi
        source ~/.config/zsh/ns.zsh
      '';
    };
    zed-editor = {
      enable = true;
      extraPackages = [ pkgs.rustc ];
      userSettings = {
        vim_mode = false;

        # Tell Zed to use direnv and direnv can use a flake.nix environment
        load_direnv = "shell_hook";
        base_keymap = "VSCode";

        ui_font_size = 14;
        agent_ui_font_size = 14;
        buffer_font_size = 11.0;
        theme = {
          mode = "dark";
          light = "One Light";
          dark = "hytx_Outrun";
        };

        show_whitespaces = "all";
        buffer_font_features = {
          calt = false;
        };
        ensure_final_newline_on_save = false;
        remove_trailing_whitespace_on_save = true;
        auto_indent_on_paste = false;
        auto_update_extensions = {
          discord-presence = false;
        };
        icon_theme = "Colored Zed Icons Theme Light";

        autosave = {
          after_delay = {
            milliseconds = 3000;
          };
        };
        lsp = {
          basedpyright = {
            binary = {
              path = "${pkgs.basedpyright}/bin/basedpyright";
            };
            settings = {
              python-analysis = {
                diagnosticMode = "workspace";
                typeCheckingMode = "standard";
              };
              venvPath = "/home/hytx/.venv";
            };
          };
          rust-analyzer = {
            binary = {
              path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
            };
            initialization_options = {
              inlayHints = {
                maxLength = null;
                lifetimeElisionHints = {
                  enable = "skip_trivial";
                  useParameterNames = true;
                };
                closureReturnTypeHints = {
                  enable = "always";
                };
              };
            };
            settings = {
              rustc = {
                source = "toolchain";
              };
              checkOnSave = {
                command = "clippy";
              };
            };
          };
          nixd = {
            binary = {
              path = "${pkgs.nixd}/bin/nixd";
            };
            settings = {
              diagnostic = {
                suppress = [ "sema-extra-with" ];
              };
            };
          };
        };
        languages = {
          Nix = {
            language_servers = [
              "nixd"
              "!nil"
            ];
          };
          Python = {
            language_servers = [
              "ty"
              "!basedpyright"
            ];
          };
          Rust = {
            language_servers = [ "rust-analyzer" ];
          };
        };
        ui_font_family = ".ZedSans";
        terminal = {
          detect_venv = {
            on = {
              directories = [ "/home/hytx/venv" ];
              activate_script = "default";
            };
          };
        };
        soft_wrap = "editor_width";
        buffer_font_family = "Hack Nerd Font Mono";
      };
    };
  };
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
