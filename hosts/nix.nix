{pkgs}: {
  #nix.settings.allowed-users = ["root"];
  #nix.extraOptions = ''
  #  keep-outputs = true
  #  keep-derivations = true
  #'';
}
