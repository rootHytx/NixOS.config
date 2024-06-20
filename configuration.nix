{ config, pkgs, lib, inputs, ... }:

{  
  imports = [
    ./boot.nix
    ./environment.nix
    ./hardware.nix
    ./i18n.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
  ];
  fonts.fontconfig.enable = true;
  powerManagement.powertop.enable = true;
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  time.timeZone = "Europe/Lisbon";
  security.rtkit.enable = true;
  sound.enable = true;
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  virtualisation.docker.enable = true;

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot  = false;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--no-write-lock-file"
        "-L" # print build logs
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };
    stateVersion = "23.11";
  };

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w"];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
             "padre-2.1.0"
           ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
