{
  config,
  pkgs,
  pkgs-unstable,
  callPackage,
  ...
}: {
  imports = [
    #../../modules/desktop/i3
    ../../modules/desktop/gnome
  ];

  fonts.fonts = with pkgs; [
    # Fonts
    carlito # NixOS
    vegur # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    (nerdfonts.override {
      # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  qt5.enable = true;
  qt5.platformTheme = "gtk2";
  qt5.style = "gtk2";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = false;
      };
    };

    desktopManager = {
      xterm.enable = false;
    };
  };
}
