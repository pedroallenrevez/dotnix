let
  l = nixpkgs.lib // builtins;

  inherit (inputs) nixpkgs std;
  inherit (std.lib) dev;

  withCategory = category: attrset: attrset // {inherit category;};
in
  l.mapAttrs (_: dev.mkShell) {
    default = {...}: {
      name = "TTT";
      nixago = with std.presets.nixago; [
        treefmt
        lefthook
        editorconfig
        # TODO [ ] - throws an error
        #(conform {configData = {inherit (inputs) cells;};})
      ];
      imports = [];
      packages = with nixpkgs; [
        manix
      ];
      commands = [
        (withCategory "hexagon" {package = inputs.nixpkgs.writedisk;})
        (withCategory "hexagon" {package = inputs.disko.packages.disko;})
        (withCategory "hexagon" {package = inputs.home.packages.home-manager;})
        #(withCategory "hexagon" {package = inputs.colmena.packages.colmena;})
        (withCategory "hexagon" {package = inputs.nixos-generators.packages.nixos-generate;})
        #(withCategory "hexagon" {
        #  name = "build-larva";
        #  help = "the hive x86_64-linux iso-bootstrapper";
        #  command = ''
        #    echo "Boostrap image is building ..."
        #    if path=$(nix build $PRJ_ROOT#nixosConfigurations._QUEEN-o-larva.config.system.build.isoImage --print-out-paths); then
        #       echo "Boostrap image build finished."
        #       echo "-------"
        #       echo "You can now burn it to a USB with the following command:"
        #       echo -e "writedisk ./result/iso/$(echo $path | cut --delimiter '-' --output-delimiter '-' -f 2-)"
        #    else
        #       echo "Boostrap image build failed."
        #    fi
        #  '';
        #})
        (withCategory "TTT" {
          name = "build";
          help = "simple TTT build";
          command = ''
            nixos-rebuild switch --flake $PRJ_ROOT#ttt
          '';
        })
        (withCategory "TTT" {
          name = "build-vm";
          help = "simple browser VM build";
          command = ''
            nix build $PRJ_ROOT#vm
          '';
        })
        (withCategory "TTT" {
          name = "build-iso";
          help = "simple browser VM build";
          command = ''
            nix build $PRJ_ROOT#ttt-install-iso
          '';
        })
      ];
    };
  }
