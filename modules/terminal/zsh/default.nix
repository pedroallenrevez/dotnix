{
  config,
  pkgs,
  pkgs-unstable,
  user,
  ...
}: {
  #environment.etc.zshrc.text = ''
  #''
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    histFile = "\${HOME}/.cache/zsh/history";
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      update_flake = "sudo nixos-rebuild switch --flake .#${user}";
    };
    ohMyZsh = {
      enable = true;
      plugins = ["git"];
      theme = "lambda";
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.${user} = {
    shell = pkgs.zsh;
  };
}
