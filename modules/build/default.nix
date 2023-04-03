{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cmake
    automake
    autobuild
    gnumake
  ];
}
