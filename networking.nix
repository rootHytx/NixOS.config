{ ... }:

{
  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 11470 ];
    bridges = {
      "br0" = {
        interfaces = [ ];
      };
    };
    interfaces = {
      br0 = {
        ipv4.addresses = [
          {
            address = "10.167.169.1";
            prefixLength = 24;
          }
        ];
      };
    };
    hostName = "nixos";
    nat = {
      enable = true;
      internalInterfaces = [ "br0" ];
      externalInterface = "enp0s13f0u1u3";
    };
    networkmanager.enable = true;
    networkmanager.settings."connection"."wifi.powersave" = 2;
  };
}
