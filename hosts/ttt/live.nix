{
  user,
  lib,
  ...
}: {
  imports = [<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>];

  # User
  users.users.ttt = {
    hashedPassword = "$y$j9T$zIAiXjiOpUmRMs3o6A.Bv/$uHjgSnKVA16PEx2J1rBHVB0OyeV9KJ0nC0GgbfEp385";
  };

  # LIVE USB ISO
  isoImage.volumeID = lib.mkForce "id-live";
  isoImage.isoName = lib.mkForce "id-live.iso";
  isoImage.makeEfiBootable = true; # EFI booting
  isoImage.makeUsbBootable = true; # USB booting
  isoImage.squashfsCompression = "lz4";

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.xserver = {
    displayManager = {
      autoLogin = {
        enable = true;
        user = "ttt";
      };
    };
  };
}
