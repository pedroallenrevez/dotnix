# Some taken from github.com/adoborrero/templates/blob/main/templates/blog/nix/settings-tcp
{user, ...}: {
  boot.kernel.sysctl = {
    # Hardening
    # Mitigates syn flooding
    "net.ipv4.tcp_syncookies" = true;
    # Incomplete protection again TIME-WAIT assassination
    "net.ipv4.tcp_rfc1337" = true;
    # Reverse path filtering - source validates packets fro mall interfaces
    # Can mitigate spoofing, as well as ip source routing from bad sources
    "net.ipv4.conf.default.rp_filter" = true;
    "net.ipv4.conf.all.rp_filter" = true;
    # We  aint a router pack!
    # Do not redirect of forward
    "net.ipv4.conf.default.accept_source_route" = false;
    "net.ipv4.conf.all.accept_source_route" = false;
    # Do not send ICMP redirects
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    # Refuse ICMP redirects (MITM mitigation)
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;

    # TCP Profile - Windows
    "net.ipv4.tcp_base_mss" = 1337;
    "net.ipv4.tcp_challenge_ack_limit" = 200;
    "net.ipv4.tcp_fin_timeout" = 360;
    "net.ipv4.tcp_synack_retries" = 2;
    "net.ipv4.tcp_max_syn_backlog" = 2048;
    "net.ipv4.tcp_max_orphans" = 12000;

    # Optimizations
    # set data in initial TCP [SYN] Packet (I/O)
    "net.ipv4.tcp_fastopen" = 3;
    # bufferbloat ? mitigations
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };
  #networking.tcpcrypt.enable = true;
  #users.users.tcpcryptd.group = "tcpcryptd";
  boot.kernelModules = ["tcp_bbr"];
}
