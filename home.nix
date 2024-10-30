{ pkgs, default, ... }:
{
  home.username = "hytx";
  home.homeDirectory = "/home/hytx";
  programs = {
    git = {
      enable = true;
      userEmail = "up201906931@up.pt";
      userName = "hytx";
    };
    neovim = {
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        elixir-tools-nvim
        nvchad-ui
      ];
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

        #security="nix-shell /etc/nixos/security_tools.nix";
        config = "zed /etc/nixos/configuration.nix";
        cripto = "cd '/home/hytx/Desktop/CYBERSEC/CRIPTOGRAFIA APLICADA'";
        cyber = "cd /home/hytx/Desktop/CYBERSEC/";
        fastfetch = "fastfetch --raw /home/hytx/.config/fastfetch/nixos.sixel --logo-width 32 --logo-height 15 --logo-padding-top 0";
        flake = "zed /etc/nixos/flake.nix";
        fraude = "cd '/home/hytx/Desktop/CYBERSEC/DETEÇÃO DE FRAUDE'";
        fsi = "cd '/home/hytx/Desktop/CYBERSEC/FSI'";
        hardware = "cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-E-APLICAÇÕES-DE-HARDWARE-CONFIÁVEL";
        home = "zed /etc/nixos/home.nix";
        kali = "quickemu --vm /home/hytx/vms/kali-current.conf";
        ll = "ls -l";
        nix-shell = "nix-shell --command zsh";
        ops = "cd '/home/hytx/Desktop/CYBERSEC/OPERAÇÕES DE SEGURANÇA'";
        rebuild = "sudo nixos-rebuild switch";
        redes = "cd /home/hytx/Desktop/CYBERSEC/TÓPICOS-AVANÇADOS-EM-REDES";
        segredes = "cd '/home/hytx/Desktop/CYBERSEC/SEGURANÇA DE REDES'";
        ses = "cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-EM-ENGENHARIA-SOFTWARE";
        sistemas = "cd /home/hytx/Desktop/CYBERSEC/SISTEMAS-EMBUTIDOS";
        ssd = "cd /home/hytx/Desktop/CYBERSEC/SEGURANÇA-DE-SISTEMAS-E-DADOS";
        ssh-add-keys = "source /home/hytx/scripts/ssh_add_script.sh";
        tools = "subl /etc/nixos/security_tools.nix";
        tpas = "cd '/home/hytx/Desktop/CYBERSEC/TEORIA E PRÁTICA DE ATAQUES DE SEGURANÇA'";
        venv = "source /home/hytx/venv/bin/activate";
        fsi-ctfcicd-source = "/home/hytx/Desktop/CYBERSEC/FSI/CICD/ctf-cicd/.env";
        caido = "docker run --rm -p 7000:8080 -d caido/caido:latest";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "thefuck"
        ];
        custom = "$HOME/.config/zsh/";
        theme = "my_custom_theme";
      };
      history.size = 10000;
      history.path = "/home/hytx/.config/zsh/history";
      initExtra = ''
        export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
        export RUSTC_VERSION=$(echo "''${$(rustup toolchain list | tail -1)//-x86_64-unknown-linux-gnu/}")
        RUSTC_VERSION_NO_UNDERLINE=$(echo $RUSTC_VERSION | tr -d '\n')
        export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION_NO_UNDERLINE-x86_64-unknown-linux-gnu/bin/
        export PROTOBUF_LOCATION=/nix/store/$(ls -1 /nix/store | grep protobuf-25.3 | tail -n1)
        export PROTOC=$PROTOBUF_LOCATION/bin/protoc
        export PROTOC_INCLUDE=$PROTOBUF_LOCATION/include
        export PATH=$PATH:/home/hytx/go/bin/
        export PKG_CONFIG_PATH=/nix/store/$(ls -1 /nix/store | grep openssl-3.0.14-dev | tail -n1)/lib/pkgconfig
        fastfetch -c /home/hytx/.config/fastfetch/preset.jsonc --raw /home/hytx/.config/fastfetch/nixos.sixel --logo-width 32 --logo-height 15 --logo-padding-top 0
      '';
    };
  };
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
