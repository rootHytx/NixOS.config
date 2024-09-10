{config, pkgs, lib, inputs, ...}:

{
 networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 9993 631 ];
      allowedUDPPorts = [ 8080 9993 631 ];
      #trustedInterfaces = [ "73a15e146065937a" ];
    };
  };
}
