{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.settings."connection"."wifi.powersave" = 2;
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
      extraCommands = '''';
    };
  };
}
