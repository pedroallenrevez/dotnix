{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  # not this local deployment, but elsewhere
  disko = pkgs.writeShellScriptBin "disko" ''${config.system.build.disko}'';
  disko-mount = pkgs.writeShellScriptBin "disko-mount" "${config.system.build.mountScript}";
  disko-format = pkgs.writeShellScriptBin "disko-format" "${config.system.build.formatScript}";
  install-system = pkgs.writeShellScriptBin "install-system" ''
    set -euo pipefail

    echo "Formatting disks..."
    . ${disko-format}/bin/disko-format

    echo "Mounting disks..."
    . ${disko-mount}/bin/disko-mount

    echo "Installing system..."
    nixos-install --system x86_64-linux

    echo "Done!"
  '';
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  environment.systemPackages = [
    install-system
    disko
    disko-mount
    disko-format
  ];
  disko.enableConfig = lib.mkDefault false;
  disko.devices = {
    disk = {
      sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              type = "partition";
              name = "ESP";
              start = "1MiB";
              end = "100MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "root";
              type = "partition";
              start = "100MiB";
              end = "100%";
              part-type = "primary";
              bootable = true;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            }
          ];
        };
      };
    };
  };
}
