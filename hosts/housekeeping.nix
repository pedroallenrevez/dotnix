{pkgs, ...}: {
  # ======================FLAKE
  boot.loader.systemd-boot.configurationLimit = 5;
  nix = {
    package = pkgs.nixFlakes;
    # We need this so we don't add this flag everytime we want to build a flake
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    #gc = {                                  # Automatic garbage collection
    #  automatic = true;
    #  dates = "weekly";
    #  options = "--delete-older-than 7d";
    #};

    #package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    #registry.nixpkgs.flake = nixpkgs;
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    #   keep-outputs          = true
    #   keep-derivations      = true
    # '';
    extraOptions = "experimental-features = nix-command flakes";
  };
}
