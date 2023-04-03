{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  user,
  NIXVERSION,
  ...
}: {
  programs = {
    home-manager.enable = true;
    # Fancy replacement for cat
    #bat.enable = true;

    # Navigate directory trees
    #broot = {
    #  enable = true;
    #  enableZshIntegration = true;
    #};

    # Easy shell environments
    direnv = {
      enable = true;
      enableZshIntegration = true;

      nix-direnv.enable = true;

      #stdlib = ''
      #  use_riff() {
      #    watch_file Cargo.toml Cargo.lock
      #    eval "$(riff print-dev-env)"
      #  }
      #'';
    };
    #bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';
    #zsh.interactiveShellInit = ''eval "$(direnv hook bash)"'';

    # Replacement for ls
    exa = {
      enable = true;
      enableAliases = true;
    };

    # Fuzzy finder
    #fzf = {
    #  enable = true;
    #  enableZshIntegration = true;
    #};

    git = {
      enable = true;
      userName = "pedroallenrevez";
      userEmail = "pedroallenrevez@gmail.com";
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
    };
    profiles.default.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      privacy-badger
      #https-everywhere
      #bitwarden
      clearurls
      decentraleyes
      duckduckgo-privacy-essentials
      #floccus
      ghostery
      privacy-redirect
      privacy-badger
      #languagetool
      #disconnect
      #react-devtools
    ];
  };

  home = {
    username = user;
    homeDirectory = "/home/${user}";

    # PACKAGES
    packages = with pkgs; [
      w3m
      brasero
      thunderbird
      #firefox
      librewolf
      zathura
      vlc
      torrential
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions;
          []
          ++
          # When the extension is already available in the default extensions set.
          [
            esbenp.prettier-vscode
            zhuangtongfa.material-theme
            kamadorueda.alejandra
            yzhang.markdown-all-in-one
            editorconfig.editorconfig
            vscodevim.vim
            ms-toolsai.jupyter
            ms-python.python
            njpwerner.autodocstring
            ms-pyright.pyright
            jnoortheen.nix-ide # TODO: how to configure
            svelte.svelte-vscode
          ]
          # Concise version from the vscode market place when not available in the default set.
          ++ vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "gitlab-workflow";
              publisher = "GitLab";
              version = "3.56.0";
              sha256 = "sha256-jWNX/S+cCgQmjRKCN9osffBlJJhrKa65yhTt1z5+8VQ=";
            }
          ];
      })
    ];

    stateVersion = NIXVERSION;
  };

  gtk = {
    # Theming
    enable = true;
    theme = {
      name = "Catppuccin-Dark";
      package = pkgs-unstable.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium"; # or FiraCode Nerd Font Mono Medium
    }; # Cursor is declared under home.pointerCursor
  };

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs-unstable.catppuccin-cursors.mochaDark;
    size = 16;
  };
}
