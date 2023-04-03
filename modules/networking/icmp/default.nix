{
  boot.kernel.sysctl = {
    "net.ipv6.icmp.echo_ignore_anycast" = true;
    "net.ipv6.icmp.echo_ignore_multicast" = true;
    "net.ipv4.icmp_echo_enable_probe" = false;
    "net.ipv4.icmp_echo_ignore_all" = true;
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    "net.ipv6.icmp.echo_ignore_all" = true; # 0;
    "net.ipv4.icmp_ignore_bogus_error_responses" = true;
  };
}
