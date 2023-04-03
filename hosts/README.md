├── default.nix
├── housekeeping.nix
└── user
├── default.nix
├── boot.nix
├── desktop.nix
├── hardware-configuration.nix
├── home.nix
├── live.nix
├── locale.nix
└── user.nix

Here we define a generalistic user.
A template user will then ingest the requirements for module imports.

It's structured as follows:

## `default.nix`

- The entrypoint defines the channels we are using and associating them with a host.

1. In the example we see we define `<nixpkgs>` as `pkgs` and `<nixpkgs-unstable>` to `pkgs-unstable`.
2. It also links the `home-manager` NixModule, so the user can have space to edit the configuration in
   user space. There he can define desktop apps, and other software we might want etc.
3. It passes down state variables for this configuration such as Nix version, and a generic username.

## `housekeeping.nix`

1. Takes care of pkg gargabe collection in a pre-defined period of 7days.
2. How many Nix generations to keep

## `user/default.nix`

Imports base user files (boot, user, locale).
Defines the module preference imports for the user

## `user locale.nix`

Shall be generated with Calamares

## `user user.nix`

Shall be generated with Calamares

## `user boot.nix`

Defines the boot options for this user.
Shall be generated with Calamares

## `user home.nix`

Defines user specific applications, for example favorite browser, video player etc.

## `user desktop.nix`

Defines the desktop environment and other theme options for the operating system.
Defines gtk theme, as well as pointer cursors.

## `user hardware-configuration.nix`

Auto-generated. Ignored if system is being built for a live version, or installer.

## `user live.nix`

This file contains the specifications to be able to burn a bootable ISO.
