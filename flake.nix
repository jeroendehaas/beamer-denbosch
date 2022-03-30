{
  inputs.flake-utils.url = github:numtide/flake-utils;
  outputs = { self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
       in rec {
         packages.beamer-denbosch = pkgs.stdenvNoCC.mkDerivation {
           pname = "beamer-denbosch";
           version = "0.1";
           tlType = "run";
           src = builtins.path { path = ./.; name = "beamer-denbosch-src"; };
           unpackPhase = "true";
           buildPhase = "true";
           installPhase = ''
             dst="$out/latex/beamer-denbosch"
             mkdir -p "$dst"
             cp *.sty "$dst"
           '';
         };
         defaultPackage = packages.beamer-denbosch;
    });
}
