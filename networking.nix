{config, pkgs, lib, inputs, ...}:

{
   networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 9993 ];
      #trustedInterfaces = [ "73a15e146065937a" ];
    };
  };
}
