let
  sources = import ../nix/sources.nix;
  neuron = import sources.neuron { };
in
_: _:
{
  inherit neuron;
}
