{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    kernelParams = [
      "kvm.enable_virt_at_load=0"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    kernelPackages = pkgs.linuxPackages_latest;

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = true;
  };
}
