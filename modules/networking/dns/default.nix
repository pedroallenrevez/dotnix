{
  imports = [
    #./dnscrypt.nix
  ];
  services.resolved.enable = false;
  networking.nameservers = [
    "1.0.0.1"
    "1.1.1.1"
  ];
}
