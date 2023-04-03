{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      macchanger
      tcpdump
      netcat
      inetutils
      unixtools.netstat
      dig
      iptables
      nftables
      arp-scan
      iw
      (
        python3.withPackages
        (
          ps:
            with ps; [
              scapy
              paramiko
            ]
        )
      )
    ];
  };
}
