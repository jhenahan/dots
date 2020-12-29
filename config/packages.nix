{ pkgs }:
with pkgs;
let
  exe = haskell.lib.justStaticExecutables;
  apps = [
    Firefox
    Dash
  ];
  tools = {
    rust = [
      bottom
      fd
      hyperfine
      procs
      ripgrep
      sd
      tokei
      xsv
    ];
    dhall = [
      dhall
      dhall-bash
      dhall-docs
      dhall-json
      dhall-nix
      dhall-yaml
    ];
    haskell = [ pandoc ];
    vc = with gitAndTools; [
      bfg-repo-cleaner
      diff-so-fancy
      git-crypt
      git-imerge
      git-lfs
      gitflow
      hub
      tig
      pijul
    ];
    nix = [
      cachix
      niv
      nix-prefetch-scripts
      nodePackages.node2nix
      nixfmt
    ];
    gnu = [
      coreutils
      findutils
      gawk
      gnugrep
      gnused
      gnutar
      parallel
      patch
      patchutils
      renameutils
      less
    ];
    work = [
      alks
      awscli
    ];
    network = [
      httpie
      dnsutils
      netcat
      openssh
      curl
      wget
      youtube-dl
      rsync
    ];
  };
  archive = [
    p7zip
    unrar
    unzip
    zip
    xz
  ];
  languageServers = [
    dhall-lsp
    metals
    terraform-ls
    terraform-lsp
    texlab
    yaml-language-server
  ];
  other = [
    mill
    bash
    emacs-all-the-icons-fonts
    texFull
    neuron
    myEmacs
    gnupg
    gpgme
    imagemagickBig
    m-cli
    paperkey
    qrencode
    rlwrap
    xquartz
    terraform-docs
    bitwarden-cli
  ];
in
pkgs.lib.lists.flatten [
  apps
  tools.rust
  tools.dhall
  tools.haskell
  tools.vc
  tools.nix
  tools.gnu
  tools.work
  tools.network
  archive
  languageServers
  other
]
