{
  config,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      wireguard-tools
      openresolv
      #tailscale
    ];
  };
}
