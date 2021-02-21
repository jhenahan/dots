{ pkgs, ... }:
{
  enable = true;
  useBabelfish = true;
  babelfishPackage = pkgs.babelfish;
}
