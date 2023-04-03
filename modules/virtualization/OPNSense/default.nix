{
  config,
  pkgs,
  user,
  ...
}: let
  IP = "192.168.122.217";
in {
  # environment.systemPackages = with pkgs; [
  #   (python3.withPackages
  #     (ps:
  #       with ps; [
  #         pyopnsense
  #             ]
  #           )
  #         )
  # ];

  # Configure network proxy if necessary
  #networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.default = IP;
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
