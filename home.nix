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
    zsh = {
      package = default.zsh;
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        clear = "clear ; fastfetch-custom";
        config = "zed /etc/nixos/";
        ctfd = "docker compose -f /home/hytx/Desktop/CYBERSEC/xstf/CTFd-local/docker-compose.yml";
        cyber = "cd /home/hytx/Desktop/CYBERSEC/";
        fastfetch-custom = "fastfetch --config ~/.config/fastfetch/preset1.jsonc";
        minecraft = "nix-shell -p steam --run 'steam-run java -jar /home/hytx/Games/TLauncher/TLauncher.jar'";
        nervctf = "cd '/home/hytx/Desktop/CYBERSEC/tese/NervCTF'";
        nfu = "ulimit -n 4096; prev=$(pwd) ; /etc/nixos ; _ nix flake update ; rebuild ; cd $prev";
        #nix-shell = "nix-shell --command 'source /home/hytx/.zshrc'";
        rebuild = "sudo nixos-rebuild switch";
        venv = "source ~/.venv/bin/activate";
        xstf = "cd /home/hytx/Desktop/CYBERSEC/xstf";
        zed = "zeditor";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        custom = "$HOME/.config/zsh/";
        theme = "custom-normal";
      };
      history.size = 10000;
      history.path = "/home/hytx/.config/zsh/history";
      initContent = ''
        export ZSH_COMPDUMP=/tmp/.zcompdump-$HOST
        export PATH=$PATH:/home/hytx/go/bin/
        if [[ -n $IN_NIX_SHELL ]]; then
            TERM_APPEARANCE="[nix-shell]"
        else
            unset TERM_APPEARANCE; fastfetch --config ~/.config/fastfetch/preset1.jsonc
        fi
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
          ty = {
            binary = {
              path = "${pkgs.ty}/bin/ty";
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
              path_lookup = true;
            };
            settings = {
              diagnostic = {
                suppress = [ "sema-extra-with" ];
              };
            };
          };
          discord_presence = {
            initialization_options = {
              application_id = "1263505205522337886";
              base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";

              state = "Working on {filename}";
              details = "";
              large_image = "{base_icons_url}/{language}.png";
              large_text = "{language:u}";
              small_image = "{base_icons_url}/zed.png";
              small_text = "Zed";

              idle = null;

              rules = {
                mode = "blacklist";
                paths = [ "/etc/nixos/" ];
              };

              git_integration = true;
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
