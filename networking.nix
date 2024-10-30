{...}:

{
 networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 8080 9993 631 3000 5007 ];
      allowedUDPPorts = [ 80 8080 9993 631 3000 5007 ];
      #trustedInterfaces = [ "73a15e146065937a" ];
    };
  };
}
