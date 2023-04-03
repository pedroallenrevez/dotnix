{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./arp
    ./dhcp
    ./dns
    ./firewall
    ./icmp
    ./igmp
    ./ipv6
    ./kernopts.nix
    ./mdns
    ./proxy
    ./quic
    ./ssh
    ./stp
    ./tcp
    ./udp
    ./vpn
  ];
  # ==-=-=-=-=-=-=-==- NETWORKING
  networking.hostName = "CarlosMacbook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking = {
    networkmanager.enable = true;
  };

  networking.usePredictableInterfaceNames = false;

  environment = {
    systemPackages = with pkgs; [
      netcat
      inetutils
      unixtools.netstat
      dig
      iptables
      nftables
      arp-scan
      iw
      tcpdump
      fail2ban
      wireshark
      nmap
      macchanger
    ];
  };
}
