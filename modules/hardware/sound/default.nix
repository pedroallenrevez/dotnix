{pkgs, ...}: {
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    daemon.config = {flat-volumes = "no";};
    package = pkgs.pulseaudioFull;
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
  ];
}
