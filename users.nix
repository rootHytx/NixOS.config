{pkgs, inputs, ...}:

{
  users.users = {
    hytx = {
      isNormalUser = true;
      shell=pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        alacritty
        fastfetch
        firefox
        gimp
        ghidra
        libreoffice-qt
        libreswan
        markdown-oxide
        neovim
        inputs.nixd.packages."${pkgs.system}".nixd
        nixfmt-rfc-style
        nmap
        nodejs_22
        openssl
        pptp
        qt6.full
        rust-analyzer
        spotify
        stremio
        sublime4
        thefuck
        thunderbird
        unzip
        vesktop
        vlc
        inputs.zed-editor.packages."${pkgs.system}".zed-editor
        zoom-us
      ];
    };
  };
}
