PATH=$(find /nix/store -type d | grep $1 | grep -e "/nix/store/[0-9a-z]*-$1-[0-9]*\.[0-9]*\.*[0-9]*$" | head -n 1)
echo $PATH
alias nix-store=/run/current-system/sw/bin/nix-store
DEPS=$(nix-store -qR $PATH)
echo $DEPS
nix-store --export $DEPS >exports/$1
