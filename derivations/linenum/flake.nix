#git revision is c47f9b226d3ce2848629f25fe142c1b2986bc427
#path is /nix/store/rd9cjdwhx0lq4qk4rpa21vggg0b8rcbh-LinEnum
#git human-readable version is -- none --
#Commit date is 2020-01-07 09:20:33 +0000
#hash is 0mw28wv60rh1rny5bx164a62091jb65a3iy2k4yzm74ckh96fap4
#{
#  "url": "https://github.com/rebootuser/LinEnum",
#  "rev": "c47f9b226d3ce2848629f25fe142c1b2986bc427",
#  "date": "2020-01-07T09:20:33+00:00",
#  "path": "/nix/store/rd9cjdwhx0lq4qk4rpa21vggg0b8rcbh-LinEnum",
#  "sha256": "0mw28wv60rh1rny5bx164a62091jb65a3iy2k4yzm74ckh96fap4",
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
      pname = "linenum";
      pkgs = nixpkgs.legacyPackages.${system};
      app = pkgs.stdenv.mkDerivation {
        name = pname;
        version = "2.11";

        src = pkgs.fetchFromGitHub {
          owner = "rebootuser";
          repo = "LinEnum";
          rev = "c47f9b226d3ce2848629f25fe142c1b2986bc427";
          sha256 = "0mw28wv60rh1rny5bx164a62091jb65a3iy2k4yzm74ckh96fap4";
        };
        buildInputs = [pkgs.bash pkgs.makeWrapper];
        phases = ["installPhase" "patchPhase" "checkPhase"];
        installPhase = ''
          mkdir -p $out/bin
          cp $src/LinEnum.sh $out/bin/linenum
          substituteInPlace $out/bin/linenum --replace '/bin/bash' ${pkgs.bash}/bin/bash
          chmod +x $out/bin/linenum
        '';
        checkPhase = ''
          $out/bin/linenum
        '';
      };
    in {
      packages.${pname} = app;
      defaultPackage = self.packages.${system}.${pname}; # <- add this
    });
}
