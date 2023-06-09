{
  config,
  pkgs,
  user,
  ...
}: {
  # virtualbox
  users.extraGroups.vboxusers.members = [user];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

  environment.systemPackages = with pkgs; [
    virtualbox
  ];
}
