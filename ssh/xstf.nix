{
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
    hostname = "ctfd.tailfff72.ts.net";
    user = "hytx";
  };

  "upCTF-challs" = {
    host = "upCTF-challs";
    hostname = "46.225.117.62";
    user = "root";
  };
}
