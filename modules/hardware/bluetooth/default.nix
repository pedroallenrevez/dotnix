{pkgs, ...}: {
  # =-=-=-=-= BLUETOOTH
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;
  programs.dconf.enable = true;
  #services.dbus.packages = [ pkgs.blueman pkgs.foliate ];
}
