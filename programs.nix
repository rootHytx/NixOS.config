{ pkgs, ... }:
{
  programs = {
    virt-manager.enable = true;
    zsh.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = false;
      package = pkgs.steam.override {
        extraLibraries = (
          pkgs: [
            pkgs.openssl
            pkgs.nghttp2
            pkgs.libidn2
            pkgs.rtmpdump
            pkgs.libpsl
            pkgs.curl
            pkgs.krb5
            pkgs.keyutils
          ]
        );
      };
    };
  };
}
