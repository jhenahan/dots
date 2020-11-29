self: super:
{
  texFull = super.texlive.combine {
    inherit (super.texlive) scheme-full texdoc latex2e-help-texinfo;
    pkgFilter = pkg:
      pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "latex2e-help-texinfo";
  };
}
