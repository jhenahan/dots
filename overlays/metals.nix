let
  sources = import ../nix/sources.nix;
  unstable = import sources.unstable { overlays = [ ]; };
in
_: _:
{
  inherit unstable;
  metals = unstable.metals;
}
