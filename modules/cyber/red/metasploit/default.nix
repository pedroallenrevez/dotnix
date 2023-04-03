{
  config,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      metasploit
    ];
  };

  # This option creates a database called
  services.postgresql.ensureDatabases = [
    "metasploit3"
  ];
}
