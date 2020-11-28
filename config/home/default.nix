{ pkgs, ... }:
let
  home_directory = builtins.getEnv "HOME";
in
rec {
  home.packages = import ../packages.nix { inherit pkgs; };
  home = {
    stateVersion = "20.09";
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
    fish = import ./fish.nix { inherit pkgs programs xdg; };
    alacritty = import ./alacritty.nix;
    jq = {
      enable = true;
    };
    starship = {
     enable = true;
     settings = {
       format = ''
         [┌─乱]$all
         [└─λ]
       '';
       add_newline = false;
     };
    };
    ssh = {
      enable = true;
      forwardAgent = true;
      serverAliveInterval = 60;
      hashKnownHosts = true;
      compression = true;
      userKnownHostsFile = "~/.config/ssh/known_hosts";
      matchBlocks = {
        default = {
          host = "*";
          identityFile = "~/.config/ssh/id_local";
          identitiesOnly = true;
        };
      };
    };
    direnv = {
      enable = true;
    };
    skim = {
      enable = true;
      defaultCommand = ''rg --color=always --line-number "{}"'';
      defaultOptions = [ "--ansi" "--regex" ];
      fileWidgetCommand = ''fd --type f'';
      fileWidgetOptions = [ "--preview 'head {}'" ];
    };
    bat = {
      enable = true;
      config = { theme = "gruvbox"; };
    };
    broot = {
      enable = true;
    };
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Jack Henahan";
      userEmail = "root@proofte.ch";
      signing = {
        key = "17F07DF3086C4BBFA5799F38EF21DED4826AAFCF";
        signByDefault = true;
      };
      aliases = {
        co = "checkout";
        cp = "cherry-pick";
        dc = "diff --cached";
        dh = "diff HEAD";
        ds = "diff --staged";
        undo = "reset --soft HEAD^";
        ri = "rebase --interactive";
        w = "status -sb";
        l = "log --graph --pretty=format:'%Cred%h%Creset" + " —%Cblue%d%Creset %s %Cgreen(%cr)%Creset'" + " --abbrev-commit --date=relative --show-notes=*";
      };
      extraConfig = {
        core = {
          trustctime = false;
          fsyncobjectfiles = true;
          logAllRefUpdates = true;
          precomposeunicode = false;
          whitespace = "trailing-space,space-before-tab";
        };
        branch = {
          autosetupmerge = "always";
          autosetuprebase = "always";
        };
        github.user = "jhenahan";
        pull.rebase = true;
        rebase.autosquash = true;
        rerere.enabled = true;
        http.sslverify = true;
        color = {
          status = "auto";
          branch = "auto";
          interactive = "auto";
          ui = "auto";
          sh = "auto";
        };
        push = {
          default = "tracking";
          recurseSubmodules = "check";
        };
        merge = {
          conflictstyle = "diff3";
          stat = true;
        };
        submodule = { recurse = true; };
        diff = {
          ignoreSubmodules = "dirty";
          renames = "copies";
          mnemonicprefix = true;
        };
        advice = {
          statusHints = false;
          pushNonFastForward = false;
        };
      };
      ignores = [
        "*.elc"
        "*.vo"
        "*.aux"
        "*.v.d"
        "*.o"
        "*.a"
        "*.la"
        "*.so"
        "*.dylib"
        "*~"
        "#*#"
        ".makefile"
        ".clean"
        ".envrc"
        ".direnv"
        "*.glob"
        ".DS_Store"
        "*~"
        "\\#*\\#"
        "/.emacs.desktop"
        "/.emacs.desktop.lock"
        "*.elc"
        "auto-save-list"
        "tramp"
        ".\#*"
        ""
        "# Org-mode"
        ".org-id-locations"
        "*_archive"
        ""
        "# flymake-mode"
        "*_flymake.*"
        ""
        "# eshell files"
        "/eshell/history"
        "/eshell/lastdir"
        ""
        "# elpa packages"
        "/elpa/"
        ""
        "# reftex files"
        "*.rel"
        ""
        "# AUCTeX auto folder"
        "/auto/"
        ""
        "# cask packages"
        ".cask/"
        "dist/"
        ""
        "# Flycheck"
        "flycheck_*.el"
        ""
        "# server auth directory"
        "/server/"
        ""
        "# projectiles files"
        ".projectile"
        ""
        "# directory configuration"
        ".dir-locals.el"
        ""
        "# network security"
        "/network-security.data"
        ""
        ""
        "### Haskell ###"
        "dist"
        "dist-*"
        "cabal-dev"
        "*.o"
        "*.hi"
        "*.chi"
        "*.chs.h"
        "*.dyn_o"
        "*.dyn_hi"
        ".hpc"
        ".hsenv"
        ".cabal-sandbox/"
        "cabal.sandbox.config"
        "*.prof"
        "*.aux"
        "*.hp"
        "*.eventlog"
        ".stack-work/"
        "cabal.project.local"
        "cabal.project.local~"
        ".HTF/"
        ".ghc.environment.*"
        ""
        "### LaTeX ###"
        "## Core latex/pdflatex auxiliary files:"
        "*.lof"
        "*.log"
        "*.lot"
        "*.fls"
        "*.out"
        "*.toc"
        "*.fmt"
        "*.fot"
        "*.cb"
        "*.cb2"
        ".*.lb"
        ""
        "## Intermediate documents:"
        "*.dvi"
        "*.xdv"
        "*-converted-to.*"
        "# these rules might exclude image files for figures etc."
        "# *.ps"
        "# *.eps"
        "# *.pdf"
        ".pdf"
        "## Bibliography auxiliary files (bibtex/biblatex/biber):"
        "*.bbl"
        "*.bcf"
        "*.blg"
        "*-blx.aux"
        "*-blx.bib"
        "*.run.xml"
        "## Build tool auxiliary files:"
        "*.fdb_latexmk"
        "*.synctex"
        "*.synctex(busy)"
        "*.synctex.gz"
        "*.synctex.gz(busy)"
        "*.pdfsync"
        ""
        "## Build tool directories for auxiliary files"
        "# latexrun"
        "latex.out/"
        ""
        "## Auxiliary and intermediate files from other packages:"
        "# algorithms"
        "*.alg"
        "*.loa"
        ""
        "# achemso"
        "acs-*.bib"
        ""
        "# amsthm"
        "*.thm"
        ""
        "# beamer"
        "*.nav"
        "*.pre"
        "*.snm"
        "*.vrb"
        ""
        "# changes"
        "*.soc"
        ""
        "# comment"
        "*.cut"
        ""
        "# cprotect"
        "*.cpt"
        ""
        "# elsarticle (documentclass of Elsevier journals)"
        "*.spl"
        ""
        "# endnotes"
        "*.ent"
        ""
        "# fixme"
        "*.lox"
        ""
        "# feynmf/feynmp"
        "*.mf"
        "*.mp"
        "*.t[1-9]"
        "*.t[1-9][0-9]"
        "*.tfm"
        ""
        "#(r)(e)ledmac/(r)(e)ledpar"
        "*.end"
        "*.?end"
        "*.[1-9]"
        "*.[1-9][0-9]"
        "*.[1-9][0-9][0-9]"
        "*.[1-9]R"
        "*.[1-9][0-9]R"
        "*.[1-9][0-9][0-9]R"
        "*.eledsec[1-9]"
        "*.eledsec[1-9]R"
        "*.eledsec[1-9][0-9]"
        "*.eledsec[1-9][0-9]R"
        "*.eledsec[1-9][0-9][0-9]"
        "*.eledsec[1-9][0-9][0-9]R"
        ""
        "# glossaries"
        "*.acn"
        "*.acr"
        "*.glg"
        "*.glo"
        "*.gls"
        "*.glsdefs"
        ""
        "# uncomment this for glossaries-extra (will ignore makeindex's style files!)"
        "# *.ist"
        ""
        "# gnuplottex"
        "*-gnuplottex-*"
        ""
        "# gregoriotex"
        "*.gaux"
        "*.gtex"
        ""
        "# htlatex"
        "*.4ct"
        "*.4tc"
        "*.idv"
        "*.lg"
        "*.trc"
        "*.xref"
        ""
        "# hyperref"
        "*.brf"
        ""
        "# knitr"
        "*-concordance.tex"
        "# TODO Comment the next line if you want to keep your tikz graphics files"
        "*.tikz"
        "*-tikzDictionary"
        ""
        "# listings"
        "*.lol"
        ""
        "# luatexja-ruby"
        "*.ltjruby"
        ""
        "# makeidx"
        "*.idx"
        "*.ilg"
        "*.ind"
        ""
        "# minitoc"
        "*.maf"
        "*.mlf"
        "*.mlt"
        "*.mtc[0-9]*"
        "*.slf[0-9]*"
        "*.slt[0-9]*"
        "*.stc[0-9]*"
        ""
        "# minted"
        "_minted*"
        "*.pyg"
        ""
        "# morewrites"
        "*.mw"
        ""
        "# nomencl"
        "*.nlg"
        "*.nlo"
        "*.nls"
        ""
        "# pax"
        "*.pax"
        ""
        "# pdfpcnotes"
        "*.pdfpc"
        ""
        "# sagetex"
        "*.sagetex.sage"
        "*.sagetex.py"
        "*.sagetex.scmd"
        ""
        "# scrwfile"
        "*.wrt"
        ""
        "# sympy"
        "*.sout"
        "*.sympy"
        "sympy-plots-for-*.tex/"
        ""
        "# pdfcomment"
        "*.upa"
        "*.upb"
        ""
        "# pythontex"
        "*.pytxcode"
        "pythontex-files-*/"
        ""
        "# tcolorbox"
        "*.listing"
        ""
        "# thmtools"
        "*.loe"
        ""
        "# TikZ & PGF"
        "*.dpth"
        "*.md5"
        "*.auxlock"
        ""
        "# todonotes"
        "*.tdo"
        ""
        "# vhistory"
        "*.hst"
        "*.ver"
        ""
        "# easy-todo"
        "*.lod"
        ""
        "# xcolor"
        "*.xcp"
        ""
        "# xmpincl"
        "*.xmpi"
        ""
        "# xindy"
        "*.xdy"
        ""
        "# xypic precompiled matrices"
        "*.xyc"
        ""
        "# endfloat"
        "*.ttt"
        "*.fff"
        ""
        "# Latexian"
        "TSWLatexianTemp*"
        ""
        "## Editors:"
        "# WinEdt"
        "*.bak"
        "*.sav"
        ""
        "# Texpad"
        ".texpadtmp"
        ""
        "# LyX"
        "*.lyx~"
        ""
        "# Kile"
        "*.backup"
        ""
        "# KBibTeX"
        "*~[0-9]*"
        ""
        "# auto folder when using emacs and auctex"
        "./auto/*"
        "*.el"
        ""
        "# expex forward references with \gathertags"
        "*-tags.tex"
        ""
        "# standalone packages"
        "*.sta"
        ""
        "### LaTeX Patch ###"
        "# glossaries"
        "*.glstex"
        ""
        "### macOS ###"
        "# General"
        ".DS_Store"
        ".AppleDouble"
        ".LSOverride"
        ""
        "# Icon must end with two \r"
        "Icon"
        ""
        "# Thumbnails"
        "._*"
        ""
        "# Files that might appear in the root of a volume"
        ".DocumentRevisions-V100"
        ".fseventsd"
        ".Spotlight-V100"
        ".TemporaryItems"
        ".Trashes"
        ".VolumeIcon.icns"
        ".com.apple.timemachine.donotpresent"
        ""
        "# Directories potentially created on remote AFP share"
        ".AppleDB"
        ".AppleDesktop"
        "Network Trash Folder"
        "Temporary Items"
        ".apdisk"
      ];
    };
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

