{
  config,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      tor
      torsocks
      tor-browser-bundle-bin
      obfs4
    ];
  };
  services.tor = {
    enable = true; # socks slow at 9050
    # Will also enable `privoxy` for routing HTTP traffic to torsocks, at 8118
    # torsocks also blackholes all UDP traffic as well as private IP traffic
    client.enable = true; # Torsocks - faster socks at 9063
  };
  services.tor.settings = {
    UseBridges = true;
    ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/obfs4proxy";
    Bridge = "obfs4 IP:ORPort [fingerprint]";
  };
}
