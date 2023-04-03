{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      exploitdb
      #gvm-libs
      #gvm-tools
    ];
  };
}
