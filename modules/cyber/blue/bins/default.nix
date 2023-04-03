{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      binwalk
      ghidra
      cutter
    ];
  };
}
