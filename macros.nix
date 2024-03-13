{pkgs, ...}:
{
	  environment.interactiveShellInit = ''
	  	fastfetch
	    alias config="subl /etc/nixos/configuration.nix";
	    alias macros="subl /etc/nixos/macros.nix";
	    alias tools="subl /etc/nixos/security_tools.nix";
	    alias bashrc="subl /etc/nixos/shell_options.nix";
	    alias rebuild="sudo nixos-rebuild switch";
	    alias disc="discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
	    alias spot="spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
	    alias showpaths="cd /home/hytx/Desktop && python showpaths.py";
	    alias sort="cd /home/hytx/Desktop/ && python sort.py";
	    alias push="bash /home/hytx/push.sh";
	    alias rustrover="nix-shell /etc/nixos/rustshell.nix --command 'rust-rover &'";
	    alias journal="xournalpp &";
	'';
}