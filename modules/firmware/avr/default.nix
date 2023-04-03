{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    flashrom
    avrdude
  ];
}
