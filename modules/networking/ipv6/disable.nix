{
  networking = {
    enableIPv6 = false;
    nat.enableIPv6 = false;
  };
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = false;
    "net.ipv6.conf.default.forwarding" = false;
    "net.ipv6.conf.lo.forwarding" = false;
    "net.ipv6.conf.wlp2s0.forwarding" = false;
    "net.ipv6.conf.wlp0s20u1.forwarding" = false;
    "net.ipv6.conf.wlp0s20u5.forwarding" = false;

    "net.ipv6.conf.lo.disable_ipv6" = true;
    "net.ipv6.conf.all.disable_ipv6" = true;
    "net.ipv6.conf.default.disable_ipv6" = true;
    "net.ipv6.conf.wlp2s0.disable_ipv6" = true;
    "net.ipv6.conf.wlp0s20u1.disable_ipv6" = true;
    "net.ipv6.conf.wlp0s20u5.disable_ipv6" = true;

    "net.ipv6.conf.all.autoconf" = false;
    "net.ipv6.conf.all.ignore_routes_with_linkdown" = true;
    "net.ipv6.conf.default.ignore_routes_with_linkdown" = true;
    "net.ipv6.conf.default.autoconf" = false;

    "net.ipv6.bindv6only" = false;
  };
}
