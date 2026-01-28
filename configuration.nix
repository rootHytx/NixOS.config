{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./environment.nix
    ./fonts.nix
    ./i18n.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./hardware.nix
  ];
  time.timeZone = "Europe/London";
  home-manager.backupFileExtension = "backup";

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  console.keyMap = "pt-latin1";
  security.rtkit.enable = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
  nix.settings = {
    trusted-users = [ "root" ];
    auto-optimise-store = true;
  };
  nixpkgs.config = {
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
    allowBroken = true;
  };
  security = {
    wrappers.qemu-bridge-helper = {
      ### FOR THE QEMU VM BRIDGING TO HOST INTERFACE (see networking.nix and environment.nix)
      setuid = true;
      owner = "root";
      group = "root";
    };
    pam.services.login.enableGnomeKeyring = true;
  };
  system.stateVersion = "24.05"; # Did you read the comment?
}
