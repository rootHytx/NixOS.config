{
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
}
