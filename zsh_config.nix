{pkgs, config, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      journal="xournalpp";
      rustrover="nix-shell /etc/nixos/rustshell.nix --command 'jetbrains-toolbox &'";
      push="elvish /home/hytx/push.elv";
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
      bashrc="nvim /home/hytx/.bashrc";
      redes="cd /home/hytx/Desktop/CYBERSEC/TÓPICOS-AVANÇADOS-EM-REDES";
      cyber="cd /home/hytx/Desktop/CYBERSEC/";
      config="nvim /etc/nixos/configuration.nix";
      fraude="cd '/home/hytx/Desktop/CYBERSEC/DETEÇÃO DE FRAUDE'";
      tpas="cd '/home/hytx/Desktop/CYBERSEC/TEORIA E PRÁTICA DE ATAQUES DE SEGURANÇA'";
      security="nix-shell /etc/nixos/security_tools.nix";
    };
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      custom = "$HOME/.config/zsh/";
      theme = "my_custom_theme";
    };
    histSize = 10000;
    histFile = "/home/hytx/.config/zsh/history";
    interactiveShellInit = ''
      if [ $(ps aux | grep -c hypr) -lt 2 ]; then	
        Hyprland
      fi
      fastfetch
    '';
  };
}
