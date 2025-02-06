{ pkgs, default, ... }:
let
  cursorName = "capitaine-cursors";
  cursorPackage = pkgs.capitaine-cursors;
  cursorSize = 24;
in
{
  home = {
    username = "hytx";
    homeDirectory = "/home/hytx";
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
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
    defaultApplications = {
      "application/pdf" = "firefox.desktop";
    };
  };
  programs = {
    git = {
      enable = true;
      userEmail = "up201906931@up.pt";
      userName = "hytx";
    };
    zsh = {
      package = default.zsh;
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        caido = "docker run --rm -p 7000:8080 -d caido/caido:latest";
        config = "zed /etc/nixos/";
        ctfd = "docker compose -f /home/hytx/Desktop/CYBERSEC/FSI/local_teste/CTFd/docker-compose.yml";
        cyber = "cd /home/hytx/Desktop/CYBERSEC/";
        dbr = "/home/hytx/Desktop/ctf/build_run_docker.sh";
        dp = "cd '/home/hytx/Desktop/CYBERSEC/DIREITO-PRIVACIDADE'";
        #fastfetch = "fastfetch --raw /home/hytx/.config/fastfetch/nixos.sixel --logo-width 32 --logo-height 15 --logo-padding-top 0";
        fsi = "cd '/home/hytx/Desktop/CYBERSEC/FSI'";
        fsi-ctfcicd-source = "/home/hytx/Desktop/CYBERSEC/FSI/CICD/ctf-cicd/.env";
        gsi = "cd '/home/hytx/Desktop/CYBERSEC/GSI'";
        kali = "quickemu --vm /home/hytx/vms/kali-current.conf";
        ll = "ls -l";
        nervctf = "cd '/home/hytx/Desktop/CYBERSEC/FSI/CICD/NervCTF'";
        nix-shell = "nix-shell --command zsh";
        rust = "nix-shell /etc/nixos/rustshell.nix";
        ops = "cd '/home/hytx/Desktop/CYBERSEC/OPERAÇÕES-DE-SEGURANÇA'";
        rebuild = "sudo nixos-rebuild switch";
        sectools = "nix-shell /etc/nixos/security_tools.nix";
        ssd = "cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-DE-SISTEMAS-E-DADOS";
        ssh-add-keys = "source /home/hytx/scripts/ssh_add_script.sh";
        venv = "source /home/hytx/venv/bin/activate";
        zed = "zeditor";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "thefuck"
        ];
        custom = "$HOME/.config/zsh/";
        theme = "custom-normal";
      };
      history.size = 10000;
      history.path = "/home/hytx/.config/zsh/history";
      initExtra = ''
        export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
          export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin
          export PROTOC=${pkgs.protobuf_28}/bin/protoc
        export ZSH_COMPDUMP=/tmp/.zcompdump-$HOST
        export PATH=$PATH:/home/hytx/go/bin/
        if [ -z $TERM_PROGRAM ]; then
            fastfetch -c /home/hytx/.config/fastfetch/preset1.jsonc
        fi
        if [[ -n $IN_NIX_SHELL ]]; then
            TERM_APPEARANCE="nix-shell"
        else
            TERM_APPEARANCE="$(whoami)@$(echo $HOST)"
        fi
      '';
    };
  };
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
