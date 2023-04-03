{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./serial
    ./arduino
    ./avr
    ./inspection
  ];
}
