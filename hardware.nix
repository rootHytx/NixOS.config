{config, pkgs, lib, inputs, ...}:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    graphics.enable = true;
    enableAllFirmware  = true;
    sensor.iio.enable = true;
  };
}
