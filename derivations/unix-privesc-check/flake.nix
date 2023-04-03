#git revision is c7d27e8a2d2d54540778c6d7c1c5bcc290dbba1a
#path is /nix/store/r3ph2xk0jsid9f22gi10bkqxdwqgr7z8-unix-privesc-check
#git human-readable version is -- none --
#Commit date is 2021-02-07 21:47:46 +0000
#hash is 02nglxrpczl7vg933nmkhdnlv7zrgvxdyrd6dg5aqschsax7xd50
#{
#  "url": "https://github.com/pentestmonkey/unix-privesc-check",
#  "rev": "c7d27e8a2d2d54540778c6d7c1c5bcc290dbba1a",
#  "date": "2021-02-07T21:47:46+00:00",
#  "path": "/nix/store/r3ph2xk0jsid9f22gi10bkqxdwqgr7z8-unix-privesc-check",
#  "sha256": "02nglxrpczl7vg933nmkhdnlv7zrgvxdyrd6dg5aqschsax7xd50",
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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pname = "unix-privesc-check";
      pkgs = nixpkgs.legacyPackages.${system};
      app = pkgs.stdenv.mkDerivation {
        name = pname;
        version = "2.11";

        src = pkgs.fetchFromGitHub {
          owner = "pentestmonkey";
          repo = "unix-privesc-check";
          rev = "c7d27e8a2d2d54540778c6d7c1c5bcc290dbba1a";
          sha256 = "02nglxrpczl7vg933nmkhdnlv7zrgvxdyrd6dg5aqschsax7xd50";
        };
        buildInputs = [pkgs.bash pkgs.makeWrapper];
        phases = ["installPhase" "patchPhase" "checkPhase"];
        installPhase = ''
          mkdir -p $out/bin
          cp $src/upc.sh $out/bin/unix-privesc-check
          substituteInPlace $out/bin/unix-privesc-check --replace '/bin/bash' ${pkgs.bash}/bin/bash
          chmod +x $out/bin/unix-privesc-check
        '';
        checkPhase = ''
          $out/bin/unix-privesc-check
        '';
      };
    in {
      packages.${pname} = app;
      defaultPackage = self.packages.${system}.${pname}; # <- add this
    });
}
