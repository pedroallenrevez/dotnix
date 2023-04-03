{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      airgeddon

      # essential
      aircrack-ng
      pciutils
      #awk
      iproute
      xterm
      iw

      # optional
      crunch
      mdk4
      #mdk3
      hashcat
      hashcat-utils
      hcxtools
      hcxdumptool
      iptables
      nftables
      bettercap
      lighttpd
      hostapd
      #hostapd-wpe
      reaverwps
      ettercap
      bully
      pixiewps
      #asleap
      openssl
      dnsmasq
      dhcp
      #tshark
      wireshark-cli
      #beef

      #update
      curl

      # internal
      usbutils
      wget
      util-linux # rfkill
      ccze
      ethtool

      # additional
      kismet
    ];
  };
}
