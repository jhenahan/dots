{ config, lib, pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
  home = builtins.getEnv "HOME";
  current_user = builtins.getEnv "USER";
in
{
  imports = [ <home-manager/nix-darwin> ];
  nixpkgs.config = import ../nixpkgs;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.${current_user} = { pkgs, ... }: {
    home.packages = import ../packages.nix { inherit pkgs; };
  };
  #environment.shells = [ pkgs.fish ];
  services = {
    nix-daemon.enable = true;
    activate-system.enable = true;
  };
  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [
      "root"
      current_user
      "@admin"
      "@wheel"
    ];
    maxJobs = 10;
    buildCores = 7;
    gc.automatic = true;
    gc.options = "--max-freed \$((25 * 1024**3 - 1024 * \$(df -P -k /nix/store | tail -n 1 | awk '{ print \$4 }')))";
    distributedBuilds = false;
    binaryCaches = [
      https://cache.nixos.org
      https://nix-tools.cachix.org
      https://hercules-ci.cachix.org
      https://hydra.iohk.io
      https://cache.dhall-lang.org
      https://dhall.cachix.org
    ];
    binaryCachePublicKeys = [
      cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
      nix-tools.cachix.org-1:ebBEBZLogLxcCvipq2MTvuHlP7ZRdkazFSQsbs0Px1A=
      hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0=
      hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=
      cache.dhall-lang.org:I9/H18WHd60olG5GsIjolp7CtepSgJmM2CsO813VTmM=
      dhall.cachix.org-1:8laGciue2JBwD49ICFtg+cIF8ddDaW7OFBjDb/dHEAo=
    ];
  };
  users.nix.configureBuildUsers = true;
  users.nix.nrBuildUsers = 32;
  #programs.fish = {
  #  enable = true;
  #};
  #programs.tmux = {
  #  enable = true;
  #  enableMouse = true;
  #  enableFzf = true;
  #  enableVim = true;
  #  enableSensible = true;
  #  defaultCommand = "${pkgs.fish}/bin/fish --login";
  #};
  programs.nix-index.enable = true;
  system.stateVersion = 3;
}
