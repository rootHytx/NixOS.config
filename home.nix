{ pkgs, default, ... }:
let
  cursorName = "capitaine-cursors";
  cursorPackage = pkgs.capitaine-cursors;
  cursorSize = 24;
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
      "x-scheme-handler/http" = "brave.desktop";
      "x-scheme-handler/https" = "brave.desktop";
      "x-scheme-handler/about" = "brave.desktop";
      "x-scheme-handler/unknown" = "brave.desktop";
      "application/pdf" = "brave.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/mp4" = "vlc.desktop";
      "video/x-msvideo" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/ogg" = "vlc.desktop";
      "video/x-flv" = "vlc.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/jpg" = "org.gnome.eog.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "image/bmp" = "org.gnome.eog.desktop";
      "image/tiff" = "org.gnome.eog.desktop";
      "image/webp" = "org.gnome.eog.desktop";
      "image/x-icon" = "org.gnome.eog.desktop";
      "image/svg+xml" = "org.gnome.eog.desktop";
      "x-scheme-handler/terminal" = "Alacritty.desktop";
      "text/plain" = "dev.zed.Zed.desktop";
      "text/x-csrc" = "dev.zed.Zed.desktop";
      "text/html" = "dev.zed.Zed.desktop";
      "text/x-c++src" = "dev.zed.Zed.desktop";
      "text/x-python" = "dev.zed.Zed.desktop";
      "text/x-shellscript" = "dev.zed.Zed.desktop";
      "application/json" = "dev.zed.Zed.desktop";
      "application/xml" = "dev.zed.Zed.desktop";
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
        dbr = "/home/hytx/Desktop/ctf/build_run_docker.sh";
        dp = "cd '/home/hytx/Desktop/CYBERSEC/DIREITO-PRIVACIDADE'";
        fastfetch-custom = "fastfetch --config ~/.config/fastfetch/preset1.jsonc";
        fsi = "cd '/home/hytx/Desktop/CYBERSEC/FSI'";
        fsi-ctfcicd-source = "/home/hytx/Desktop/CYBERSEC/FSI/CICD/ctf-cicd/.env";
        git-backup = "/home/hytx/scripts/push_git.sh";
        google-chrome-stable = "google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform-hint=auto --start-fullscreen";
        gsi = "cd '/home/hytx/Desktop/CYBERSEC/GSI'";
        kali = "quickemu --vm /home/hytx/vms/kali-current.conf";
        ll = "ls -l";
        minecraft = "nix-shell -p steam --run 'steam-run java -jar /home/hytx/Games/TLauncher/TLauncher.jar'";
        nervctf = "cd '/home/hytx/Desktop/CYBERSEC/tese/NervCTF'";
        nfu = "ulimit -n 4096; prev=$(pwd) ; /etc/nixos ; _ nix flake update ; rebuild ; cd $prev";
        nix-shell = "nix-shell --command zsh";
        rust = "nix-shell /etc/nixos/rustshell.nix";
        ops = "cd '/home/hytx/Desktop/CYBERSEC/OPERAÇÕES-DE-SEGURANÇA'";
        rebuild = "sudo nixos-rebuild switch";
        sectools = "nix-shell /etc/nixos/security_tools.nix";
        ssd = "cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-DE-SISTEMAS-E-DADOS";
        ssh-add-keys = "source /home/hytx/scripts/ssh_add_script.sh";
        venv = "source ~/venv/bin/activate";
        xstf = "cd /home/hytx/Desktop/CYBERSEC/xstf";
        xstf-internal = "~/.ssh/auto_ssh.sh xstf-internal";
        xstf-bots = "~/.ssh/auto_ssh.sh xstf-bots";
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
  };
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
