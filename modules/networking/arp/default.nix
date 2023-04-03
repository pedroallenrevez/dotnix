{
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.drop_gratuitous_arp" = true;
    "net.ipv6.conf.all.drop_gratuitous_arp" = 1;
    "net.ipv4.conf.default.drop_gratuitous_arp" = 1;
    "net.ipv6.conf.default.drop_gratuitous_arp" = 1;
    "net.ipv4.conf.lo.drop_gratuitous_arp" = 1;
    "net.ipv6.conf.lo.drop_gratuitous_arp" = 1;
  };
}
