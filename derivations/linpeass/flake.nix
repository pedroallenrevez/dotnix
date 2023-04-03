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
      pname = "linpeas";
      pkgs = nixpkgs.legacyPackages.${system};
      app = pkgs.stdenv.mkDerivation {
        name = pname;
        version = "2.10";

        src = pkgs.fetchurl {
          url = "https://github.com/carlospolop/PEASS-ng/releases/download/20230129/linpeas.sh";
          sha256 = "16w2lnnvmxdqpqn57q7irrqdvx638qxa59vg15mbsaz1g7dd2r4w";
        };
        phases = ["installPhase" "patchPhase"];
        installPhase = ''
          mkdir -p $out/bin
          cp $src $out/bin/linpeas
          chmod +x $out/bin/linpeas
        '';
      };
    in {
      packages.${pname} = app;
      defaultPackage = self.packages.${system}.${pname}; # <- add this
    });
}
