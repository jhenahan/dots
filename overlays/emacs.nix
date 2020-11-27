self: super:
{
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
    package = self.emacsGcc;
    config  = ../config/emacs/the.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    extraEmacsPackages = epkgs: [
      epkgs.use-package
      epkgs.org-plus-contrib
      epkgs.auto-compile
    ];
  };
}
