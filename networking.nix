{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      allowedTCPPorts = [
        80
        8080
        9993
        631
        3000
        5007
      ];
      allowedUDPPorts = [
        80
        8080
        9993
        631
        3000
        5007
      ];
      #trustedInterfaces = [ "73a15e146065937a" ];
      extraCommands = ''iptables -A INPUT -p tcp --dport 22 -s 100.88.229.86 -j ACCEPT'';
    };
  };
}
