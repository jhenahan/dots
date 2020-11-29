{ pkgs }:
with pkgs;
let
  exe = haskell.lib.justStaticExecutables;
  gitTools = with gitAndTools; [
    git-crypt
    git-imerge
    bfg-repo-cleaner
    gitflow
    hub
    tig
    diff-so-fancy
  ];
  languageServers = [
    texlab
    metals
  ];
in
[
  texFull
  neuron
  myEmacs
  nix-prefetch-scripts
  cachix
  niv
  awscli
  coreutils
  parallel
  git-lfs
  patch
  patchutils
  pijul
  curl
  exa
  fd
  findutils
  gawk
  gnugrep
  gnupg
  gnused
  gnutar
  gpgme
  htop
  imagemagickBig
  less
  m-cli
  p7zip
  paperkey
  qrencode
  renameutils
  ripgrep
  rlwrap
  time
  unrar
  unzip
  xquartz
  xsv
  xz
  zip
  dnsutils
  netcat
  openssh
  rsync
  terraform-docs
  wget
  youtube-dl
  openssh
] ++ gitTools ++ languageServers
