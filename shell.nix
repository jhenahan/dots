let
  sources = import ./nix/sources.nix;
in
{ nixpkgs ? sources.nixpkgs
, darwin ? sources.darwin
, home-manager ? sources.home-manager
}:
let
  pkgs = import nixpkgs { };
  buildDots = "$(nix-build --no-out-link)";
  files = "$(find . -path ./nix -prune -false -o -name '*.nix')";
  lint = pkgs.writeShellScriptBin "lint" ''
    ${pkgs.nix-linter}/bin/nix-linter ${files} "$@"
  '';
  format = pkgs.writeShellScriptBin "format" ''
    ${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt ${files} "$@"
  '';
  switch = pkgs.writeShellScriptBin "switch" ''
    WORKDIR="$HOME/.dots"
    DOTFILES="$WORKDIR/dotfiles"
    NIXPKGS="$WORKDIR/nixpkgs"
    DARWIN="$WORKDIR/darwin"
    HOME_MANAGER="$WORKDIR/home-manager"
    DARWIN_CONFIG="$DOTFILES/config/darwin"
    OVERLAYS="$DOTFILES/overlays"
    mkdir -p "$WORKDIR"
    ln -snfv ${buildDots} "$DOTFILES"
    ln -snfv ${nixpkgs} "$NIXPKGS"
    ln -snfv ${darwin} "$DARWIN"
    ln -snfv ${home-manager} "$HOME_MANAGER"
    echo >&2 "Formatting..."
    format
    echo >&2 "Linting..."
    lint
    >&2 echo "Setting up nix-darwin..."
    if (! command -v darwin-rebuild); then
        echo >&2 "Installing nix-darwin..."
        echo $(nix-build '<darwin>' -A system --no-out-link)/sw/bin/darwin-rebuild switch
        $(nix-build '<darwin>' -A system --no-out-link)/sw/bin/darwin-rebuild switch \
          -I "darwin=$DARWIN" \
          -I "darwin-config=$DARWIN_CONFIG" \
          -I "nixpkgs=$NIXPKGS" \
          -I "nixpkgs-overlays=$OVERLAYS" \
          -I "home-manager=$HOME_MANAGER"
    fi
    echo >&2 "Switching to new configuration..."
    darwin-rebuild switch --show-trace \
          -I "darwin=$DARWIN" \
          -I "darwin-config=$DARWIN_CONFIG" \
          -I "nixpkgs=$NIXPKGS" \
          -I "nixpkgs-overlays=$OVERLAYS" \
          -I "home-manager=$HOME_MANAGER"
  '';
in
pkgs.mkShell { buildInputs = [ switch format lint ]; }
