{
  pkgs,
  pkgs-unstable,
  lib,
  user,
  ...
}: {
  imports = [
    # TODO - if user is live do not import hardware-configuration
    #./hardwareProfiles.nix
    #./boot.nix

    # import live.nix instead
    #./live.nix
    ./user.nix
    ./locale.nix
    ./desktop.nix
    ../../modules/networking
    ../../modules/build
    ../../modules/virtualization
    ../../modules/terminal
    ../../modules/sys-utils
    #../../modules/cyber
    #../../modules/android
    #../../modules/hardware
    #../../modules/database
  ];
}
