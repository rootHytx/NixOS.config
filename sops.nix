{ ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    age.keyFile = "/home/hytx/.config/sops/age/keys.txt";

    secrets = {
      deepseekAPIKey = {
        mode = "0400";
        owner = "root";
        group = "root";
        path = "/run/secrets/deepseek-api-key";
      };
      xSTFCTFDToken = {
        mode = "0400";
        owner = "root";
        group = "root";
        path = "/run/secrets/ctfd-token";
      };
      xSTFCTFDURL = {
        mode = "0400";
        owner = "root";
        group = "root";
        path = "/run/secrets/ctfd-url";
      };
      xSTFCTFDDeployHost = {
        mode = "0400";
        owner = "root";
        group = "root";
        path = "/run/secrets/ctfd-deploy-host";
      };
      INESCTECVPNConfig = {
        mode = "0400";
        owner = "root";
        group = "root";
        path = "/etc/openvpn/inesctec.conf";
      };
    };
  };
}
