{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./zsh
    ./alacritty
    ./nvim
  ];
  environment.systemPackages = with pkgs; [
    # =-=-=-=-=-=- EDITOR & TERMINAL
    alacritty
    pkgs-unstable.neovim
  ];
}
