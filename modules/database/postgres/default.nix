{
  config,
  pkgs,
  user,
  ...
}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 11 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE ${user} WITH LOGIN PASSWORD '${user}' CREATEDB;
      CREATE DATABASE ${user};
      GRANT ALL PRIVILEGES ON DATABASE ${user} TO ${user};
    '';
  };

  environment.systemPackages = with pkgs; [
    postgresql
    (
      python3.withPackages
      (
        ps:
          with ps; [
            psycopg2
            sqlalchemy
          ]
      )
    )
  ];
}
