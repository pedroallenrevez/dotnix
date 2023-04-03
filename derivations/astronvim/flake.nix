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
    astronvim = {
      type = "github";
      owner = "AstroNvim";
      repo = "AstroNvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    astronvim,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pname = "astronvim";
      pkgs = nixpkgs.legacyPackages.${system};
      app = pkgs.stdenv.mkDerivation {
        name = pname;
        version = "2.10";
        src = pkgs.fetchFromGitHub {
          owner = "AstroNvim";
          repo = "AstroNvim";
          rev = "4f4269d174d85df8b278a6e09d05daeef840df4a"; # git-SHA of curret master HEAD
          sha256 = "0cknamcvw7il7fbndaj9dc6g66fj32aby87iqx8akr6nl83sp4ky";
        };

        buildInputs = [pkgs.neovim pkgs.makeWrapper];
        installPhase = ''
          mkdir -p $out
          cp -r ${astronvim}/* $out
          wrapProgram ${pkgs.neovim}/bin/nvim -u "$out/init.lua"
          #${pkgs.neovim}/bin/nvim --headless +PackerSync
        '';
      };
    in {
      packages.${pname} = app;
      defaultPackage = self.packages.${system}.${pname}; # <- add this
      # nix shell, nix develop
      #devShell = pkgs.mkShell {
      #buildInputs = with haskellPackages; [
      #  haskell-language-server
      #  ghcid
      #  cabal-install
      #];
      #inputsFrom = builtins.attrValues self.packages.${system};
      #};
    });
}
