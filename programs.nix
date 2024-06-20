{config, pkgs, lib, inputs, ...}:

{
  programs = {
    thunar.enable = true;
    xfconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true; 
      #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    zsh.enable=true;
    nm-applet.enable = true;
  };
}
