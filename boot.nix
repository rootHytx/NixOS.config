{ pkgs, ... }:

{
  boot = {
    kernel = {
      sysctl = {
        "net.ipv4.ip_forward" = 1;
      };
    };

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
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
      logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
      font = "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFont-Italic.ttf";
      theme = "matrix";
      themePackages = with pkgs; [
        plymouth-matrix-theme
        (adi1090x-plymouth-themes.override {
          selected_themes = [ ];
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    loader.timeout = 0;
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
