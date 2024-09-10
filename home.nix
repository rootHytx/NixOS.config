{config, pkgs, default, ...}:
{
  nixpkgs.overlays = [
    (final: prev: {
      catppuccin-gtk = prev.catppuccin-gtk.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "catppuccin";
          repo = "gtk";
          rev = "v${old.version}";
          fetchSubmodules = true;
          hash = "sha256-q5/VcFsm3vNEw55zq/vcM11eo456SYE5TQA3g2VQjGc=";
        };
        postUnpack = "";
      });
    })
  ];
  home.username = "hytx";
  home.homeDirectory = "/home/hytx";
  gtk = {
    enable = true;
    #theme = {
    #  name = "catppuccin-macchiato-pink-compact+default";
    #  package = pkgs.catppuccin-gtk.override {
    #    accents = [ "pink" ];
    #    size = "compact";
    #    #tweaks = "default+black+rimless";
    #    variant = "macchiato";
    #  };
    #};
    theme = {
      name = "Colloid-Pink-Dark-Compact";
      package = default.colloid-gtk-theme.override{
        themeVariants = ["pink"];
        colorVariants = ["dark"];
        sizeVariants = ["compact"];
        tweaks = ["rimless"];
      };
    };
    iconTheme = {
      name = "Colloid-pink-dark";
      package = default.colloid-icon-theme.override{
        schemeVariants = ["default"];
        colorVariants = ["pink"];
      };
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  #dconf.settings = {
  #  "org/gtk/settings/file-chooser" = {
  #    sort-directories-first = true;
  #  };
  
  #  # GTK4 Setup
  #  "org/gnome/desktop/interface" = {
  #    gtk-theme = "Catppuccin-Macchiato-Compact-Pink-Dark";
  #    color-scheme = "prefer-dark";
  #  };
  #};
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = default.bibata-cursors;
    size = 24;
  };
  programs = {
    neovim = {
      extraPackages = with pkgs; [
        lua-language-server
        python-lsp-server
      ];
    };
    zsh = {  
      package = default.zsh;
      enable = true;
      enableCompletion = true;
      #autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        cona = "echo cona";
        ll = "ls -l";
        journal="xournalpp";
        rustrover="nix-shell /etc/nixos/rustshell.nix --command 'jetbrains-toolbox &'";
        push="/home/hytx/push.sh";
        disc="discord '--enable-features=UseOzonePlatform' '--ozone-platform=wayland'";
        spot="spotify '--enable-features=UseOzonePlatform' '--ozone-platform=wayland'";
        rebuild="sudo nixos-rebuild switch";
        sistemas="cd /home/hytx/Desktop/CYBERSEC/SISTEMAS-EMBUTIDOS";
        ssd="cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-DE-SISTEMAS-E-DADOS";
        ses="cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-EM-ENGENHARIA-SOFTWARE";
        hardware="cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-E-APLICAÇÕES-DE-HARDWARE-CONFIÁVEL";
        cripto="cd '/home/hytx/Desktop/CYBERSEC/CRIPTOGRAFIA APLICADA'";
        tools="subl /etc/nixos/security_tools.nix";
        ops="cd '/home/hytx/Desktop/CYBERSEC/OPERAÇÕES DE SEGURANÇA'";
        segredes="cd '/home/hytx/Desktop/CYBERSEC/SEGURANÇA DE REDES'";
        redes="cd /home/hytx/Desktop/CYBERSEC/TÓPICOS-AVANÇADOS-EM-REDES";
        cyber="cd /home/hytx/Desktop/CYBERSEC/";
        config="nvim /etc/nixos/configuration.nix";
        home="nvim /etc/nixos/home.nix";
        flake="nvim /etc/nixos/flake.nix";
        fraude="cd '/home/hytx/Desktop/CYBERSEC/DETEÇÃO DE FRAUDE'";
        tpas="cd '/home/hytx/Desktop/CYBERSEC/TEORIA E PRÁTICA DE ATAQUES DE SEGURANÇA'";
        security="nix-shell /etc/nixos/security_tools.nix";
        fastfetch="fastfetch --raw /home/hytx/.config/fastfetch/nixos.sixel --logo-width 32 --logo-height 15 --logo-padding-top 0";
        nix-shell="nix-shell --command zsh";
        pyshell="nix-shell /etc/nixos/pyshell.nix";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        custom = "$HOME/.config/zsh/";
        theme = "my_custom_theme";
      };
      history.size = 10000;
      history.path = "/home/hytx/.config/zsh/history";
      initExtra = ''
        if [ $(ps aux | grep -c hypr) -lt 2 ]; then	
          Hyprland
        fi
        fastfetch -c /home/hytx/.config/fastfetch/preset.jsonc --raw /home/hytx/.config/fastfetch/nixos.sixel --logo-width 32 --logo-height 15 --logo-padding-top 0
      '';
    };
  };
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
