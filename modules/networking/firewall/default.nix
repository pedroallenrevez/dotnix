{pkgs, ...}: {
  imports = [
    ./nftables
    #./iptables
  ];
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [80 443];
  networking.firewall.allowedUDPPorts = [];

  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Nftables/iptables toggle
  #networking.nftables.enable = true;
  #networking.firewall.package = pkgs.iptables-legacy;

  networking.firewall.allowPing = false;
  networking.firewall.logRefusedPackets = true;
  networking.firewall.extraCommands = ''
    #iptables -A nixos-fw -p udp --source-port 1900 -s 192.168.1.26 -d 192.168.1.6 -j nixos-fw-accept
  '';
}
