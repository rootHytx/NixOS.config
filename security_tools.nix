{ pkgs ? import <nixpkgs> {} }:
	pkgs.mkShell rec {
    buildInputs = with pkgs; [
		#DNS
		aiodnsbrute amass bind dnsenum
		dnsmon-go dnsmonster dnsrecon dnstake
		dnstracer dnstwist dnspeep dnsx fierce findomain
		knockpy subfinder subzerod
		#EXPLOITS
		exploitdb go-exploitdb
		keedump padre
		#FORENSICS
		gef
		ntfsprogs
		sleuthkit
		#FUZZ
		ffuf
		gobuster
		wfuzz
		#MISC
		curl
		cyberchef
		wget
		#COMMON CLIENTS
		cifs-utils freerdp net-snmp nfs-utils
		ntp openssh openvpn samba step-cli
		tightvnc wireguard-go wireguard-tools xrdp
		#MALWARE/PWN
		gdb ghidra-bin pwndbg clang clang-tools
		pwntools radare2 yara valgrind
		#MOBILE
		androguard apktool 
		dex2jar scrcpy
		#NETWORKS
		arping mitm6 netcat-gnu
		netdiscover putty whois
		#PASSWORDS
		hashcat john medusa ncrack
		#PORT-SCANNERS
		arp-scan das ipscan masscan
		naabu nmap udpx
		#PROXIES
		burpsuite mitmproxy
		#SERVICES
		metasploit nuclei mx-takeover sqlmap
		sshchecker ssh-mitm waf-tester wafw00f
		#TRAFFIC
		dhcpdump dsniff netsniff-ng
		tcpdump wireshark
		#WIRELESS
		aircrack-ng
	];
	nixpkgs.config.permittedInsecurePackages = [
		"tightvnc-1.3.10"
	];
  shellHook = ''
    export NIXPKGS_ALLOW_UNFREE=1;
  '';
}
