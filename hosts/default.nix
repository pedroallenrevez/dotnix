{
  lib,
  inputs,
  ...
}: let
  # Define generalistic variablles that you wish to pass down the configs
  NIXVERSION = "22.05";
  system = "x86_64-linux"; # System architecture
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
    overlays = [inputs.nur.overlay];
  };

  pkgs-unstable = import inputs.unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = inputs.nixpkgs.lib;
in {
  ttt = lib.nixosSystem {
    # Desktop profile
    inherit system;
    specialArgs = {
      inherit inputs pkgs pkgs-unstable NIXVERSION;
      user = "ttt";
    }; # Pass flake variable
    modules = [
      inputs.nur.nixosModules.nur
      # Modules that are used.
      ./ttt
      ./housekeeping.nix
      ./configuration.nix
      ./ttt/desktop/boot.nix
      ./ttt/desktop/hardwareProfiles.nix

      # Home-Manager module that is used.
      inputs.home.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Pass the channel down...
        home-manager.extraSpecialArgs = {
          # NOTE: Inherit variables here.
          inherit pkgs pkgs-unstable inputs NIXVERSION;
          user = "ttt";
        };
        home-manager.users.ttt = {
          imports = [(import ./ttt/home.nix)];
        };
      }
    ];
  };
}
