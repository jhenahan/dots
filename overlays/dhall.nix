let
  sources = import ../nix/sources.nix;
  edn = import sources.dhall { };
in
self: super:
{
  dhall = edn.dhall-simple;
  dhall-bash = edn.dhall-bash-simple;
  dhall-docs = edn.dhall-docs-simple;
  dhall-json = edn.dhall-json-simple;
  dhall-lsp = edn.dhall-lsp-simple;
  dhall-nix = edn.dhall-nix-simple;
  dhall-yaml = edn.dhall-yaml-simple;
}
