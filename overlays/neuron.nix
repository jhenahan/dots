let
  sources = import ../nix/sources.nix;
  neuron = import sources.neuron {};
in
self: super:
{
  inherit neuron;
}
