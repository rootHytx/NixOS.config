{ ... }:

{
  imports =
    [   ./hardware-configuration.nix
	./boot.nix
	./environment.nix
	./fonts.nix
	./i18n.nix
	./networking.nix
	./programs.nix
	./services.nix
	./users.nix
    ];
  time.timeZone = "Europe/Lisbon";

  services.xserver.enable = true;

  virtualisation.docker.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  console.keyMap = "pt-latin1";

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    '';
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1w"
              ];
  system.stateVersion = "24.05"; # Did you read the comment?
  home-manager.backupFileExtension="backup";
}
