{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      nmap
      nmapsi4

      # (python3.withPackages
      #   (ps:
      #     with ps; [
      #       python-nmap
      #    ]
      #  )
      # )
    ];
  };
}
