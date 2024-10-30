{pkgs, ...}:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
    };
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_testing;
    #kernelParams = [ "snd-intel-dspcfg.dsp_driver=1" ];
  };
}
