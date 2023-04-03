{
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.drop_unsolicited_na" = 1;
    "net.ipv6.conf.default.drop_unsolicited_na" = 1;
    "net.ipv6.conf.default.router_solicitation_delay" = 1;
    "net.ipv6.conf.default.router_solicitation_interval" = 4;
    "net.ipv6.conf.default.router_solicitations" = -1;
    "net.ipv6.conf.all.router_solicitation_delay" = 1;
    "net.ipv6.conf.all.router_solicitation_interval" = 4;
    "net.ipv6.conf.all.router_solicitations" = -1;
    "net.ipv4.neigh.default.mcast_resolicit" = false;
    "net.ipv4.neigh.default.mcast_solicit" = 0;
    "net.ipv4.neigh.default.ucast_solicit" = 1;
    "net.ipv6.neigh.default.mcast_resolicit" = false;
    "net.ipv6.neigh.default.mcast_solicit" = 0;
    "net.ipv6.neigh.default.ucast_solicit" = 1;

    "net.ipv6.anycast_src_echo_reply" = false;

    "net.ipv6.conf.all.drop_unicast_in_l2_multicast" = true;
    "net.ipv4.conf.all.drop_unicast_in_l2_multicast" = true;
    "net.ipv6.conf.default.drop_unicast_in_l2_multicast" = true;
    "net.ipv4.conf.default.drop_unicast_in_l2_multicast" = true;
    "net.ipv6.conf.lo.drop_unicast_in_l2_multicast" = true;
    "net.ipv4.conf.lo.drop_unicast_in_l2_multicast" = true;
    "net.ipv6.conf.wlp2s0.drop_unicast_in_l2_multicast" = true;
    "net.ipv4.conf.wlp2s0.drop_unicast_in_l2_multicast" = true;
    "net.ipv6.conf.wlp0s20u1.drop_unicast_in_l2_multicast" = true;
    "net.ipv4.conf.wlp0s20u1.drop_unicast_in_l2_multicast" = true;
    "net.ipv6.conf.wlp0s20u5.drop_unicast_in_l2_multicast" = true;
    "net.ipv4.conf.wlp0s20u5.drop_unicast_in_l2_multicast" = true;
  };
}
