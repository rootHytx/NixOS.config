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
          "10.70.16.2/32"
        ];
        dns = [ "10.70.16.1" ];
        privateKeyFile = config.sops.secrets.INESC_WG_PRIVKEY.path;
        peers = [
          {
            publicKey = "akaWAmsS5FzO8Xmjeru9q2n2ijgi0xpzPBKnVJFIVwY=";
            allowedIPs = [
              "10.70.16.1/24"
            ];
            endpoint = "pe01:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
