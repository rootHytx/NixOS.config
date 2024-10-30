{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    roboto
    nerdfonts
    font-awesome
    source-code-pro
  ];
}
