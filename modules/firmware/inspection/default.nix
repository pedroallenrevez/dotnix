{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    volatility3
    hexdump
    ghidra
    cutter
    binwalk
  ];
}
