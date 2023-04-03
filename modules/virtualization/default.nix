{
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./OPNSense
    #./VirtualBox
    ./docker
  ];

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_full
  ];

  # libvirtd
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  boot.kernelModules = ["kvm-amd" "kvm-intel"];
  users.users.${user}.extraGroups = ["libvirtd"];

  virtualisation.libvirtd.allowedBridges = ["virbr0"];
  virtualisation.libvirtd.onBoot = "start";
  #virtualisation.libvirtd.extraConfig
  #virtualisation.libvirtd.qemu

  # Security
  # Incurs performance cost, but more secure
  security.virtualisation.flushL1DataCache = "always";
  # Attack vector unproven, so we leave at true, performance drops
  # Had to do with shared memory areas
  security.allowSimultaneousMultithreading = true;

  #virtualisation.cores = 4;
}
