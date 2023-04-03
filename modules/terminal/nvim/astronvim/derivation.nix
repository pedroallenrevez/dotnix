{
  lib,
  stdenv,
  #, fetchurl
  #, testVersion
  pkgs,
  pkgs-unstable,
}:
stdenv.mkDerivation rec {
  pname = "astronvim";
  version = "2.10";
  builder = ./install.sh;
  buildInputs = [pkgs-unstable.neovim];

  src = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    #rev = "4d439744685b6b2492685124994120ebd1fa4abb"; # git-SHA of curret master HEAD
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  # its github package, it doesnt have a makefile check
  doCheck = false;

  #passthru.tests.version =
  #  testVersion { package = pkgs-unstable.neovim; };

  meta = with lib; {
    description = "A program that produces a familiar, friendly greeting";
    longDescription = ''
      GNU Hello is a program that prints "Hello, world!" when you run it.
      It is fully customizable.
    '';
    homepage = "https://www.gnu.org/software/hello/manual/";
    changelog = "https://git.savannah.gnu.org/cgit/hello.git/plain/NEWS?h=v${version}";
    license = licenses.gpl3Plus;
    maintainers = [maintainers.eelco];
    platforms = platforms.all;
  };
}
