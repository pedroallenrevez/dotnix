{
  # =-=-=-=-= MULTICAST DNS
  services.avahi = {
    enable = false;
    nssmdns = false;
    ipv6 = false;
    reflector = false;
  };
}
