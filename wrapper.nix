{pkgs, ...}:
	{
	environment.loginShellInit = ''
		cd ~

		export _JAVA_AWT_WM_NONREPARENTING=1

		exec Hyprland
	'';	
}