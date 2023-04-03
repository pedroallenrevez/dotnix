# NixOs

## Nix-Shell

`nix-shell` allows you to install a package and try it within it's own shell.

```
nix-shell '<nixpkgs>' -A youtube-dl
```

If you repeat the command, since the nix store is already filled in, then it will skip the download.

Use flakes with `nix develop`.

## Building

Make live iso (`live` host name)

```
nix build .#nixosConfigurations.live.config.system.build.isoImage
```

Update flake:

```
nixos-rebuild switch .#<user>
```

nixos-rebuild switch --flake .#ttt --option use-binary-caches false

## Flakes

- `flake.lock` - pins down all the versions of co-depencies (nix pkg manager <-> home-manager);
- Allows multiple hosts
- Good for git repository
  - Must add files first, before building
  - Git-aware
- Good for updating nixos and home-manager with one command (since home-manager is a "different" package manager, the functional part of it beings to get complicated.)
- Recommended for managing dotfiles.

### Getting-Started with flakes

0. In `configuration.nix`

```nix
  nix = {
  	package =pkgs.nixFlakes;
	# We need this so we don't add this flag everytime we want to build a flake
	extraOptions = "experimental-features = nix-command flakes";
  };
```

1. `mkdir cfg_home`
2. `nix flake init`
3. Inputs -> channels where we get our pkgs from
   Outputs -> output sources (pkg, configs, and modules)
4. Check flake.nix file - setup some boilerplate

```nix
outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      # inherits variable value to be imported like {self, pkgs, `system`} etc
      inherit system;
      config.allowUnfree = true;
    };
    lib = nikpkgs.lib;
  in {
    nixosConfigurations = {
      ttt = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };
```

5. `nixos-rebuild switch --flake .#<user>`
6. Complains about `fetchTarball` with no sha256, because then it cant pin the versions!
   6.1. Add 52 zeros to an empty sha256 variable
   6.2. Find sha and enter manually
7. Instead of having

```
  unstableTarball =
    fetchTarball {
      url = https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
      sha256="1501jzl4661qwr45b9ip7c7bpmbl94816draybhh60s9wgxn068d";
    };
```

add the channel to a flake input! and then pass it down the stream

## Tips

- Delete entries for broken geneartions on

```
λ ls /nix/var/nix/profiles/
drwxr-xr-x  - root 23 Dec  2020  per-user
lrwxrwxrwx 15 root 14 Oct 11:41  system -> system-105-link # Note: points to a *previous* generation.
lrwxrwxrwx 88 root  1 Oct 12:38  system-105-link -> /nix/store/cdlxkpcrz9pyrb9sjkwgjmrj06ai7zvp-nixos-system-moby-21.11pre319562.c21ba4f7bb4
lrwxrwxrwx 88 root 14 Oct 11:36  system-106-link -> /nix/store/73cny4fm4jfnqdzfm1vkz7xrj2rq4m2v-nixos-system-moby-21.11pre322478.e4ef597edfd
λ exa -l /boot/loader/entries/
.rwxr-xr-x 433 root 14 Oct 11:41 nixos-generation-105.conf
.rwxr-xr-x 433 root 14 Oct 11:41 nixos-generation-106.conf
λ doas rm /nix/var/nix/profiles/system-106-link
λ doas rm /boot/loader/entries/nixos-generation-106.conf
```

- Errors for no space left on device on /boot/efi means we have too many entries for generations. Set boot.<engine>.configurationLimit

# Resources

- NixOS:
  1. NixOS Website: https://nixos.org/
  2. NixOS Manual: https://nixos.org/manual/nixos/stable/
  3. NixOS Packages & Options: https://search.nixos.org/packages
  4. NixOS Wiki: https://nixos.wiki/wiki/Main_Page
- Home-Manager: 5. Home-Manager: https://github.com/nix-community/home... 6. Home-Manager Manual: https://nix-community.github.io/home-... 7. Home-Manager Appendix A: https://nix-community.github.io/home-... 8. Home-Manager Appendix B: https://nix-community.github.io/home-...
- Examples: 9. Personal Flake: https://github.com/MatthiasBenaets/ni... 10. List of reference configurations: https://nixos.wiki/wiki/Configuration...
- Extras: 11. NixOS Learn: https://nixos.org/learn.html/ 12. Nix Pills: https://nixos.org/guides/nix-pills/ 13. https://zero-to-nix.com/ 14. https://nix.dev/ 15. Nix one pager https://github.com/tazjin/nix-1p 16. https://github.com/nix-community/awesome-nix 17. https://github.com/nix-community/nixos-generators
- Misc:
  https://mynixos.com/

### Nix Dev Resources

https://github.com/mlvzk/manix
https://github.com/kamadorueda/alejandra
https://github.com/utdemir/nix-tree
https://github.com/oxalica/nil
https://github.com/cachix/pre-commit-hooks.nix
https://github.com/divnix/std
https://github.com/vlinkz/nixos-conf-editor

### Rust Nix

https://github.com/rvolosatovs/nixify

nix boolean expression for live or not variable
build flake with option
