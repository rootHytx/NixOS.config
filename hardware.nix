{config, pkgs, lib, inputs, ...}:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true; 
    };
    pulseaudio.enable = false;
    sensor.iio.enable = true;
  };
}
