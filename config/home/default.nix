{ pkgs, ... }:
rec {
  home.packages = import ../packages.nix { inherit pkgs; };
  home = {
    file = {
      ".emacs.d/early-init.el".source = ../emacs/early-init.el;
      ".emacs.d/init.el".source = ../emacs/init.el;
      ".emacs.d/the.org".source = ../emacs/the.org;
      ".emacs.d/pragmata.el".source = ../emacs/pragmata.el;
    };
  };
  programs = {
    man = {
      enable = true;
    };
    noti = {
      enable = true;
    };
    fish = import ./fish.nix { inherit pkgs programs; };
    alacritty = import ./alacritty.nix;
    jq = {
      enable = true;
    };
    starship = import ./starship.nix;
    ssh = import ./ssh.nix;
    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
    };
    skim = {
      enable = true;
      defaultCommand = "rg --color=always --line-number '{}'";
      defaultOptions = [ "--ansi" "--regex" ];
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [ "--preview 'head {}'" ];
    };
    bat = {
      enable = true;
      config = { theme = "gruvbox"; };
    };
    broot = {
      enable = true;
    };
    git = import ./git.nix { inherit pkgs; };
  };
  xdg = {
    configFile."gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      default-cache-ttl 600
      max-cache-ttl 7200
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      scdaemon-program ~/.config/gnupg/scdaemon-wrapper
    '';
    configFile."gnupg/scdaemon-wrapper" = {
      text = ''
        #!/bin/bash
        export DYLD_FRAMEWORK_PATH=/System/Library/Frameworks
        exec ${pkgs.gnupg}/libexec/scdaemon "$@"
      '';
      executable = true;
    };
  };
}
