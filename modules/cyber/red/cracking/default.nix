{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      hashcat
      hashcat-utils
      hcxtools
      john
      crunch
    ];
  };
}
