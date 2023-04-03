{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./recon
    ./wifi
    ./utils
    ./blue
    ./red
  ];

  environment = {
    systemPackages = with pkgs; [
      bettercap
      yersinia

      #pkgs-unstable.asnmap # Tool to gather network ranges using ASN information

      # {MISSING}
      #responder
    ];
  };
}
