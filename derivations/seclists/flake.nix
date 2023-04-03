#user = "tft";
#git revision is 4f4269d174d85df8b278a6e09d05daeef840df4a
#path is /nix/store/vj8msvbsk6lqsfcigkaixbr5436gpxzx-AstroNvim
#git human-readable version is -- none --
#Commit date is 2023-01-10 13:37:05 -0500
#hash is 0cknamcvw7il7fbndaj9dc6g66fj32aby87iqx8akr6nl83sp4ky
#{
#  "url": "https://github.com/AstroNvim/AstroNvim",
#  "rev": "4f4269d174d85df8b278a6e09d05daeef840df4a",
#  "date": "2023-01-10T13:37:05-05:00",
#  "path": "/nix/store/vj8msvbsk6lqsfcigkaixbr5436gpxzx-AstroNvim",
#  "sha256": "0cknamcvw7il7fbndaj9dc6g66fj32aby87iqx8akr6nl83sp4ky",
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
