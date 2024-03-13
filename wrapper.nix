{pkgs, ...}:
	{
	environment.loginShellInit = ''
		if [ -z "$SSH_CONNECTION" ] && [ "$XDG_SESSION_ID" = "1" ]; then
			export XDG_CURRENT_DESKTOP=Hyprland
			export XDG_SESSION_TYPE=wayland
			export XDG_SESSION_DESKTOP=Hyprland
		  	export XDG_RUNTIME_DIR=/tmp/users/$(id -u)

			export QT_AUTO_SCREEN_SCALE_FACTOR=1
			export QT_QPA_PLATFORM="wayland;xcb"
			export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

			export SDL_VIDEODRIVER=wayland
			export _JAVA_AWT_WM_NONEREPARENTING=1
			export CLUTTER_BACKEND="wayland"

			export _JAVA_AWT_WM_NONREPARENTING=1
			exec Hyprland
		fi
	'';	
}