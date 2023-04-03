{
  config,
  pkgs,
  user,
  ...
}: {
  # TODO - add docker to user groups
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    #docker
    #dockerTools
    (
      python3.withPackages
      (
        ps:
          with ps; [
            docker-compose
            poetry
            ## pip
            pypiserver
          ]
      )
    )
  ];
}
