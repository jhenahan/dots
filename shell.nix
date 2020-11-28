let
  sources = import ./nix/sources.nix;
in
{ nixpkgs      ? sources.nixpkgs
, darwin       ? sources.darwin
, home-manager ? sources.home-manager }:
let
  pkgs = import nixpkgs {};
  buildDots = "$(nix-build --no-out-link)";
  switch = pkgs.writeShellScriptBin "switch" ''
    CONFIG_DIR="$HOME/.dots"
    DOTFILES="$CONFIG_DIR/dotfiles"
    NIXPKGS="$CONFIG_DIR/nixpkgs"
    DARWIN="$CONFIG_DIR/darwin"
    HOME_MANAGER="$CONFIG_DIR/home-manager"
    DARWIN_CONFIG="$DOTFILES/config/darwin"
    OVERLAYS="$DOTFILES/overlays"
    mkdir -p "$CONFIG_DIR"
    ln -snfv ${buildDots} "$DOTFILES"
    ln -snfv ${nixpkgs} "$NIXPKGS"
    ln -snfv ${darwin} "$DARWIN"
    ln -snfv ${home-manager} "$HOME_MANAGER"
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
    echo darwin-rebuild switch --show-trace \
          -I "darwin=$DARWIN" \
          -I "darwin-config=$DARWIN_CONFIG" \
          -I "nixpkgs=$NIXPKGS" \
          -I "nixpkgs-overlays=$OVERLAYS" \
          -I "home-manager=$HOME_MANAGER"
    darwin-rebuild switch --show-trace \
          -I "darwin=$DARWIN" \
          -I "darwin-config=$DARWIN_CONFIG" \
          -I "nixpkgs=$NIXPKGS" \
          -I "nixpkgs-overlays=$OVERLAYS" \
          -I "home-manager=$HOME_MANAGER"
  '';
in
pkgs.mkShell { buildInputs = [ switch ]; }
