{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    ./nmap
    ./wireshark
  ];

  environment = {
    systemPackages = with pkgs;
      [
        thc-ipv6
        thc-hydra
        etherape
        rustscan
        zmap
        p0f
        #recon-ng5

        # DIRECTORY ENUMERATION
        gobuster

        # DNS ENUMERATION
        dnschef
        dnsrecon
        dnsenum
      ]
      ++ [
        inputs.fi6s.packages.x86_64-linux.fi6s
      ];
  };
}
