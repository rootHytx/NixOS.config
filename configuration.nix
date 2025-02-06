{ pkgs, ... }:
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
  systemd.services."NetworkManager-wait-online".enable = false;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  console.keyMap = "pt-latin1";
  security.rtkit.enable = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
  system.stateVersion = "24.05"; # Did you read the comment?
}
