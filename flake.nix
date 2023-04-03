{
  description = "The Hive - The secretly open NixOS-Society";
  inputs.std.url = "github:divnix/std";
  inputs.std.inputs.nixpkgs.follows = "nixpkgs";
  #inputs.std.inputs.mdbook-kroki-preprocessor.follows = "std/blank";
  #inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  # tools
  inputs = {
    # Our channels
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # HIVE
    nixos-generators.url = "github:blaggacao/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.inputs.nixlib.follows = "nixpkgs";
    #colmena.url = "github:zhaofengli/colmena";
    #colmena.inputs.nixpkgs.follows = "nixpkgs";
    #colmena.inputs.stable.follows = "std/blank";
    #colmena.inputs.flake-utils.follows = "std/flake-utils";
    #nixgl.url = "github:guibou/nixGL";
    #nixgl.inputs.nixpkgs.follows = "nixpkgs";
    #nixgl.inputs.flake-utils.follows = "std/flake-utils";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Our own derivations - use std for this
    astronvim.url = "path:/etc/nixos/derivations/astronvim";
    fi6s.url = "path:/etc/nixos/derivations/fi6s";
    linpeas.url = "path:/etc/nixos/derivations/linpeass";
    linenum.url = "path:/etc/nixos/derivations/linenum";
    les.url = "path:/etc/nixos/derivations/linux-exploit-suggester";
  };

  # nixpkgs & home-manager
  inputs = {
    nixos.follows = "nixos-22-11";
    home.follows = "home-22-11";

    nixos-22-11.url = "github:nixos/nixpkgs/release-22.11";
    #home-22-11.url = "github:blaggacao/home-manager/release-22.05"; # some temp fixes
    home-22-11.url = "github:nix-community/home-manager";
  };

  outputs = {
    std,
    self,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./comb;
      # debug = ["cells" "x86_64-linux"];
      cellBlocks = with std.blockTypes; [
        # modules implement
        (functions "nixosModules")
        (functions "homeModules")
        (functions "devshellModules")

        # profiles activate
        (functions "hardwareProfiles")
        (functions "nixosProfiles")
        (functions "homeProfiles")
        (functions "devshellProfiles")

        # suites aggregate profiles
        (functions "nixosSuites")
        (functions "homeSuites")

        # configurations can be deployed
        (data "nixosConfigurations")
        (data "colmenaConfigurations")
        (data "homeConfigurations")
        (data "diskoConfigurations")

        # devshells can be entered
        (devshells "devshells")

        # jobs can be run
        (runnables "jobs")

        # library holds shared knowledge made code
        (functions "library")
      ];
      nixpkgsConfig = {
        allowUnfree = true;
      };
    }
    # soil
    {
      packages.x86_64-linux = {inherit (inputs.disko.packages.x86_64-linux) disko;};
      devShells = std.harvest self ["_QUEEN" "devshells"];
    }
    {
      nixosConfigurations = ( # NixOS configurations
        import ./hosts {
          # Imports ./hosts/default.nix
          # Why import it with () like this?
          inherit (inputs.nixpkgs) lib;
          inherit inputs; # Also inherit home-manager so it does not need to be defined here.
        }
      );

      packages.x86_64-linux = {
        vm = inputs.nixos-generators.nixosGenerate {
          modules = [
            ./vm.nix
          ];
          system = "x86_64-linux";
          format = "qcow";
        };
        ttt-install-iso = inputs.nixos-generators.nixosGenerate {
          modules = [
            ({...}: {
              imports = [
                inputs.disko.nixosModules.disko
                ./hosts
              ];
            })
          ];
          system = "x86_64-linux";
          format = "install-iso";
        };
      };
    };
}
