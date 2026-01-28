{ ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    #sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
    #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    age.keyFile = "/home/hytx/.config/sops/age/keys.txt";

    secrets = {
      DEEPSEEK_API_KEY = {
        mode = "0400";
        owner = "root";
        group = "root";
      };
      XSTF_CTFD_TOKEN = {
        mode = "0400";
        owner = "root";
        group = "root";
      };
      XSTF_CTFD_URL = {
        mode = "0400";
        owner = "root";
        group = "root";
      };
      XSTF_CTFD_DEPLOY_HOST = {
        mode = "0400";
        owner = "root";
        group = "root";
      };
      INESC_VPN_CREDS = {
        mode = "0400";
        owner = "root";
        group = "root";
      };
    };
  };
}
