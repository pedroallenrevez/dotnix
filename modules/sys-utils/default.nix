{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      bat
      tldr
      silver-searcher
      ripgrep
      tree
      shellcheck
      htop
      ranger
      ncdu
      lnav
      meld
      bleachbit
      ranger
      gnome.gnome-logs
      gparted
      unrar
      unzip
      zip
      cryptsetup
      veracrypt
      #strings
    ];
  };
}
