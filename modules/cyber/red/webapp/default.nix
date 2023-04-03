{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      #burpsuite
      zap

      nikto

      # {MISSING}
      #weevely
      #webshells
      # {MISSING EXTRA}
      #beef
    ];
  };
}
