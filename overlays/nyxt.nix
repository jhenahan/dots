let
  sources = import ../nix/sources.nix;
in
self: super:
{
  nyxt = with super; stdenv.mkDerivation {
    pname = "nyxt";
    version = "git";
    src = sources.nyxt;
    nativeBuildInputs = [ ];
  };
}
