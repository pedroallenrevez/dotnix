{
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alacritty
  ];
  environment.variables = {
    TERMINAL = "alacritty";
  };
}
