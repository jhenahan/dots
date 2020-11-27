{ pkgs, ... }:
{
  home.packages = import ../packages.nix { inherit pkgs; };
  home.file.".emacs.d/early-init.el".source = ../emacs/early-init.el;
  home.file.".emacs.d/init.el".source = ../emacs/init.el;
  home.file.".emacs.d/the.org".source = ../emacs/the.org;
  home.file.".emacs.d/pragmata.el".source = ../emacs/pragmata.el;
  programs.fish = import ./fish.nix;
  programs.alacritty = import ./alacritty.nix;
  
}

