{
  pkgs,
  inputs,
  ...
}: {
  # You can monitor these logs with journalctl -f
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    "-a exit,always -F arch=b64 -S execve"
  ];
  environment.systemPackages = [
    pkgs.clamav
    pkgs.lynis
    inputs.linpeas.packages.x86_64-linux.linpeas
    inputs.linenum.packages.x86_64-linux.linenum
    inputs.les.packages.x86_64-linux.linux-exploit-suggester
  ];
}
