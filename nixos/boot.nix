{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    kernelParams = [ "kvm.enable_virt_at_load=0" ];
    kernelPackages = pkgs.linuxPackages_6_12;
    extraModulePackages = [ pkgs.wireguard-go ];
  };
}
