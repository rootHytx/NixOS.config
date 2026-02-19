{ config, ... }:

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
    wg-quick.interfaces = {
      wg0 = {
        # pubkey = jvUEesn8F3FKYaeAACCmj55VqE15mQOSC795WtMIW1E=
        address = [
          "10.59.0.2/32"
        ];
        #dns = [ "10.50.20.1" ];
        privateKeyFile = config.sops.secrets.INESC_WG_PRIVKEY.path;
        peers = [
          {
            publicKey = "akaWAmsS5FzO8Xmjeru9q2n2ijgi0xpzPBKnVJFIVwY=";
            allowedIPs = [
              "10.50.0.0/16"
            ];
            endpoint = "pe01.inesctec.pt:443";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
