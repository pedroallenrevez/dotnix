{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./tor
  ];
  environment = {
    systemPackages = with pkgs; [
      proxychains
    ];
  };
}
