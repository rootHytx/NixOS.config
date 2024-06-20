{config, pkgs, lib, inputs, ...}:

{  
boot = {
    loader = {
      systemd-boot.enable = true;
      grub = {
        enable = false;
        device = "/dev/sda";
        useOSProber = true;
      };
    };
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [ "snd-intel-dspcfg.dsp_driver=1" ];
  };
}
