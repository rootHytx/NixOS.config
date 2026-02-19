{
  "*" = {
    hashKnownHosts = true;
    controlMaster = "auto";
    controlPersist = "5m";
  };
  # DCC SSH Configurations
  "DCC" = {
    host = "DCC";
    hostname = "ssh.alunos.dcc.fc.up.pt";
    user = "up201906931";
  };

  "xstf-internal-over-dcc" = {
    host = "xstf-internal-over-dcc";
    hostname = "192.168.101.98";
    user = "xstf-internal";
    proxyJump = "DCC";
    identityFile = "~/.ssh/xstf-internal/xstf-internal";
    identitiesOnly = true;
  };

  "xstf-bots-over-dcc" = {
    host = "xstf-bots-over-dcc";
    hostname = "192.168.101.101";
    user = "xstf-bots";
    proxyJump = "DCC";
    identityFile = "~/.ssh/xstf-bots/xstf-bots";
    identitiesOnly = true;
  };

  # INESC SSH Configurations
  "k8sdev01" = {
    host = "k8sdev01";
    hostname = "10.61.14.97";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
    localForwards = [
      {
        bind.port = 8443;
        host.port = 8443;
        host.address = "10.61.14.97";
      }
      {
        bind.port = 9090;
        host.port = 9090;
        host.address = "10.61.14.97";
      }
      {
        bind.port = 9400;
        host.port = 9400;
        host.address = "10.61.14.97";
      }
      {
        bind.port = 443;
        host.port = 443;
        host.address = "10.61.14.97";
      }
      {
        bind.port = 10250;
        host.port = 10250;
        host.address = "10.61.14.97";
      }
    ];
  };

  "k8sdev02" = {
    host = "k8sdev02";
    hostname = "10.61.14.91";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
  };

  "k8sdev03" = {
    host = "k8sdev03";
    hostname = "10.61.14.185";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
  };

  "k8sdev04" = {
    host = "k8sdev04";
    hostname = "10.61.14.38";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
  };

  "k8sgpu01" = {
    host = "k8sgpu01";
    hostname = "10.61.14.94";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
  };

  "k8sgpu02" = {
    host = "k8sgpu02";
    hostname = "10.61.14.80";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
  };

  "k8sgpu03" = {
    host = "k8sgpu03";
    hostname = "10.61.14.104";
    user = "root";
    identityFile = "~/.ssh/inesc/inesc";
    identitiesOnly = true;
  };

  # Personal SSH Configurations
  "mine-server" = {
    host = "mine-server";
    hostname = "mine.tailfff72.ts.net";
    user = "mine";
  };

  "hytx-lab" = {
    host = "hytx-lab";
    hostname = "hytx-lab";
    user = "root";
  };

  # xSTF SSH Configurations
  "xstf" = {
    host = "xstf";
    hostname = "ssh.alunos.dcc.fc.up.pt";
    user = "up201906931";
    identityFile = "~/.ssh/xstf/xstf";
    localForwards = [
      {
        bind.port = 8006;
        host.port = 8006;
        host.address = "192.168.0.15";
      }
      {
        bind.port = 3128;
        host.port = 3128;
        host.address = "192.168.0.15";
      }
    ];
  };

  "xstf-internal" = {
    host = "xstf-internal";
    hostname = "100.71.129.23";
    user = "xstf-internal";
    identityFile = "~/.ssh/xstf-internal/xstf-internal";
    identitiesOnly = true;
  };

  "xstf-bots" = {
    host = "xstf-bots";
    hostname = "100.68.218.106";
    user = "xstf-bots";
    identityFile = "~/.ssh/xstf-bots/xstf-bots";
    identitiesOnly = true;
  };

  "xstf-router" = {
    host = "xstf-router";
    hostname = "100.79.171.99";
    user = "root";
    identityFile = "~/.ssh/xstf-router/xstf-router";
    identitiesOnly = true;
  };

  "sala-1" = {
    host = "sala-1";
    hostname = "sala-1.tailfff72.ts.net";
    user = "root";
  };

  "sala-2" = {
    host = "sala-2";
    hostname = "sala-2.tailfff72.ts.net";
    user = "root";
  };

  "sala-hytx" = {
    host = "sala-hytx";
    hostname = "sala-hytx.tailfff72.ts.net";
    user = "root";
  };

  "outline" = {
    host = "outline";
    hostname = "outline.tailfff72.ts.net";
    user = "root";
  };

  "upCTF-CTFd" = {
    host = "upCTF-CTFd";
    hostname = "46.225.107.220";
    user = "root";
  };

  "upCTF-challs" = {
    host = "upCTF-challs";
    hostname = "46.225.117.62";
    user = "root";
  };
}
