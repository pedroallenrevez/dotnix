{user, ...}: {
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    # wheel is for sudo
    extraGroups = ["networkmanager"];
  };
}
