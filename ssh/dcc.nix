{
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
}
