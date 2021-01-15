{ config, lib, pkgs, ... }:
let
  current_user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
in
{
  imports = [ <home-manager/nix-darwin> ];
  users.users.${current_user}.home = home;
  nix.nixPath = [
    "darwin=$HOME/.dots/darwin"
    "home-manager=$HOME/.dots/home-manager"
    "darwin-config=$HOME/.dots/dotfiles/config/darwin"
    "nixpkgs=$HOME/.dots/nixpkgs"
  ];
  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = config.environment.systemPackages ++ config.home-manager.users.${current_user}.home.packages;
    pathsToLink = "/Applications";
  });
  nixpkgs.config = import ../nixpkgs;
  nixpkgs.overlays = let path = ../../overlays; in
    with builtins;
    map (n: import (path + ("/" + n)))
      (filter
        (n: match ".*\\.nix" n != null ||
          pathExists (path + ("/" + n + "/default.nix")))
        (attrNames (readDir path)));
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.${current_user} = import ../home;
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  services = {
    nix-daemon.enable = true;
    activate-system.enable = true;
    spacebar = {
      enable = true;
      package = pkgs.spacebar;
      config = {
        text_font = "PragmataPro Liga:Regular:12.0";
        icon_font = "PragmataPro Liga:Regular:12.0";
        background_color = "0xff282828";
        foreground_color = "0xffebdbb2";
        space_icon_strip = "I II III IV V VI VII VIII IX X";
        power_icon_strip = "🔋 🔌";
        space_icon = "*";
        clock_icon = "⏰";
        clock_format = "%F %R %z";
      };
    };
    yabai = {
      enable = true;
      package = pkgs.yabai;
      config = {
        mouse_follows_focus = "on";
        focus_follows_mouse = "autoraise";
        window_placement = "second_child";
        window_border = "on";
        window_border_width = 2;
        active_window_border_color = "0xffcc241d";
        normal_window_border_color = "0xff458588";
        layout = "bsp";
        top_padding = 26;
        bottom_padding = 0;
        left_padding = 0;
        right_padding = 0;
        window_gap = 5;
      };
    };
  };
  nix = {
    package = pkgs.nixStable;
    trustedUsers = [
      "root"
      current_user
      "@admin"
      "@wheel"
    ];
    maxJobs = 10;
    buildCores = 8;
    #gc.user = current_user;
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
  users.knownGroups = [ "nixbld" ];
  services.lorri.enable = true;
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
  system.stateVersion = 4;
}
