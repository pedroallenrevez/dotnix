{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./webapp
    ./metasploit
    ./cve
    ./cracking
  ];
}
