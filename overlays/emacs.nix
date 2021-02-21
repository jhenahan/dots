let
  sources = import ../nix/sources.nix;
in
self: super:
{
  tree-sitter-grammars = super.stdenv.mkDerivation rec {
    name = "tree-sitter-grammars";
    version = "0.9.1";
    src = super.fetchzip {
      url = "https://dl.bintray.com/ubolonton/emacs/tree-sitter-grammars-macos-${version}.tar.gz";
      stripRoot = false;
      sha256 = "1vm1m10wgb2lim27wgaag4d6x2hk1h0ir84gq30qbcabi6whg2m1";
    };
    installPhase = ''
      install -d $out/langs/bin
      install -m444 * $out/langs/bin
      echo -n $version > $out/langs/bin/BUNDLE-VERSION
    '';
  };
  emacsGcc = super.emacsGcc.overrideAttrs (old: {
    postInstall = old.postInstall or "" + super.lib.optionalString super.stdenv.isDarwin ''
      ln -snf $out/lib/emacs/28.0.50/native-lisp $out/native-lisp
      ln -snf $out/lib/emacs/28.0.50/native-lisp $out/Applications/Emacs.app/Contents/native-lisp
      cat <<EOF> $out/bin/run-emacs.sh
      #!/usr/bin/env bash
      set -e
      exec $out/bin/emacs-28.0.50 "\$@"
      EOF
      chmod a+x $out/bin/run-emacs.sh
      ln -snf ./run-emacs.sh $out/bin/emacs
    '';
  });
  myEmacs = super.emacsWithPackagesFromUsePackage {
    package = super.emacsGcc.override {
      libgccjit = super.gcc9.cc.override {
        name = "libgccjit";
        langFortran = false;
        langCC = false;
        langC = false;
        profiledCompiler = false;
        langJit = true;
        enableLTO = false;
      };
    };
    config = ../config/emacs/the.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    override = epkgs: epkgs // {
      ligature = epkgs.trivialBuild { pname = "ligature"; src = sources.emacs-ligature; };
      epithet = epkgs.trivialBuild { pname = "epithet"; src = sources.epithet; };
      tree-sitter-langs = epkgs.tree-sitter-langs.overrideAttrs (oldAttrs: {
        postPatch = oldAttrs.postPatch or "" + ''
          substituteInPlace ./langs/tree-sitter-langs-build.el \
          --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${self.tree-sitter-grammars}/langs\""
        '';
      });
    };
    extraEmacsPackages = epkgs: [
      epkgs.use-package
      epkgs.org-plus-contrib
      epkgs.auto-compile
    ];
  };
}
