{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      lynis
    ];
  };
}
