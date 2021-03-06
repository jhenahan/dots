{ pkgs, programs, ... }:
{
  enable = true;
  shellAliases = rec {
    ls = "br -sdp";
    l = ls;
    e = "${pkgs.myEmacs}/bin/emacsclient -c";
    E = "sudo -e";
    cat = "bat";
    ti = "hyperfine";
    loc = "tokei";
    ps = "procs";
    top = "btm";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    sw = "pushd ~/src/dots; nix-shell --run 'switch'; popd";
  };
  loginShellInit = ''
    set fish_greeting
    set -x GPG_TTY (tty)
    if not pgrep -x "gpg-agent" > /dev/null
      ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
    end
  '';
  shellInit = ''
    set -x SSH_AUTH_SOCK "$HOME/.config/gnupg/S.gpg-agent.ssh";
    set -x GNUPGHOME "$HOME/.config/gnupg";

    set -x CABAL_CONFIG "$HOME/.config/cabal/config";
    set -x LESSHISTFILE "$HOME/.cache/less/history";
    set -x SCREENRC "$HOME/.config/screen/config";
    set -x WWW_HOME "$HOME/.cache/w3m";
    set -x FONTCONFIG_PATH "$HOME/.config/fontconfig";
    set -x FONTCONFIG_FILE "$HOME/.config/fontconfig/fonts.conf";
    set -x ALTERNATE_EDITOR "";
    set -x EDITOR "${pkgs.myEmacs}/bin/emacsclient -c";
    set -x VISUAL $EDITOR
    set -x EMAIL "${programs.git.userEmail}";
    set -x LC_CTYPE "en_US.UTF-8";
    set -x LESS "-FRSXM";
    set -x PROMPT_DIRTRIM "2";
    set -x WORDCHARS "";
    function wtr -a format
      set -q format[1]; and set -l f "&format=$format[1]"; or set -l f ""
      curl "https://wttr.in/?m$f"
    end
    function cheat -a topic
      set -q topic[1]; and curl "https://cht.sh/$topic[1]/$argv[2..-1]"
    end
    function vterm_printf;
        if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end 
            # tell tmux to pass the escape sequences through
            printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
        else if string match -q -- "screen*" "$TERM"
            # GNU screen (screen, screen-256color, screen-256color-bce)
            printf "\eP\e]%s\007\e\\" "$argv"
        else
            printf "\e]%s\e\\" "$argv"
        end
    end
    if [ "$INSIDE_EMACS" = 'vterm' ]
        function clear
            vterm_printf "51;Evterm-clear-scrollback";
            tput clear;
        end
    end
  '';
}
