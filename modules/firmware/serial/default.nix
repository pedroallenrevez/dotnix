{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    putty
    picocom
    (
      python3.withPackages
      (
        ps:
          with ps; [
            pyserial
          ]
      )
    )
  ];
}
