let
  sources = import ../nix/sources.nix;
  unstable = import sources.unstable { overlays = []; };
in
self: super:
{
  inherit unstable;
  starship = unstable.starship;
}
