#hash is 1ylpfjs4ifqn1ii90pb15l9b4j7nxj1cymcmpgh8f66xc3ldynfz
#{
#  "url": "https://github.com/sfan5/fi6s",
#  "rev": "8d5ddba481de6cc37f2f4eb13a4c29b12150b8e9",
#  "date": "2022-12-30T22:27:04+01:00",
#  "path": "/nix/store/1s20insvqq86v0dsgh9ih49x6rf2mnf3-fi6s",
#  "sha256": "1ylpfjs4ifqn1ii90pb15l9b4j7nxj1cymcmpgh8f66xc3ldynfz",
#  "fetchLFS": false,
#  "fetchSubmodules": false,
#  "deepClone": false,
#  "leaveDotGit": false
#}
{
  description = "Package the hello repeater.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fi6s = {
      type = "github";
      owner = "sfan5";
      repo = "fi6s";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    fi6s,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pname = "fi6s";
      pkgs = nixpkgs.legacyPackages.${system};
      app = pkgs.stdenv.mkDerivation {
        name = pname;
        version = "2.10";
        src = pkgs.fetchFromGitHub {
          owner = "sfan5";
          repo = "fi6s";
          rev = "8d5ddba481de6cc37f2f4eb13a4c29b12150b8e9";
          sha256 = "1ylpfjs4ifqn1ii90pb15l9b4j7nxj1cymcmpgh8f66xc3ldynfz";
        };
        buildInputs = [pkgs.libpcap];
        buildPhase = ''
          make BUILD_TYPE=release
        '';
        installPhase = ''
                 mkdir -p $out/bin
          cp ./fi6s $out/bin
        '';
      };
    in {
      packages.${pname} = app;
      defaultPackage = self.packages.${system}.${pname}; # <- add this
    });
}
