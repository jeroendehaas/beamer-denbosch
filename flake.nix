{
  inputs.flake-utils.url = github:numtide/flake-utils;
  outputs = { self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
          latex-beamer-denbosch-raw = pkgs.stdenvNoCC.mkDerivation {
           pname = "latex-beamertheme-denbosch";
           version = "0.1";
           passthru.tlType = "run";

           src = builtins.path { path = ./.; name = "beamertheme-denbosch-src"; };

           buildPhase = "true";
           installPhase = ''
             dst="$out/tex/latex/beamertheme-denbosch"
             mkdir -p "$dst"
             cp *.sty "$dst"
           '';
         };
       in {
         packages = {
           inherit latex-beamer-denbosch-raw;
           latex-beamertheme-denbosch = {
             pkgs = [
               latex-beamer-denbosch-raw
             ];
           };
         };
    });
}
