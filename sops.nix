{ ... }:
let
  mode = "0400";
  owner = "root";
  group = "root";
in
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    #sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
    #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    age.keyFile = "/home/hytx/.config/sops/age/keys.txt";

    secrets = {
      DEEPSEEK_API_KEY = {
        mode = mode;
        owner = owner;
        group = group;
      };
      XSTF_CTFD_TOKEN = {
        mode = mode;
        owner = owner;
        group = group;
      };
      XSTF_CTFD_URL = {
        mode = mode;
        owner = owner;
        group = group;
      };
      XSTF_CTFD_DEPLOY_HOST = {
        mode = mode;
        owner = owner;
        group = group;
      };
      INESC_VPN_CREDS = {
        mode = mode;
        owner = owner;
        group = group;
      };
    };
  };
}
