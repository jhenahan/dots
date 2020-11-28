#let
#  sources = import ../nix/sources.nix;
#in
_: super:
{
  # .oO someday
  #alacritty = super.alacritty.overrideAttrs (old: rec {
  #  src = sources.alacritty-ligatures;
  #  cargoDeps = old.cargoDeps.overrideAttrs (super.lib.const {
  #    inherit src;
  #    outputHash = "sha256-e0aQO4lL6bwZJqqHt0bVFn0aSyvVZyMm97mJXiEQy8U=";
  #  });
  #});
}
