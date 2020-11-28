{ pkgs, programs, xdg, ... }:
{
  enable = true;
  shellAliases = rec {
    ls = "exa";
    l = ls;
    ll = "exa -al";
    e = "$EDITOR";
    E = "sudo -e";
    cat = "bat";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };
  loginShellInit = ''
    set fish_greeting
    set -x GPG_TTY (tty)
    if not pgrep -x "gpg-agent" > /dev/null
      ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
    end
  '';
  shellInit = ''
    set -x SSH_AUTH_SOCK "~/.config/gnupg/S.gpg-agent.ssh";
    set -x GNUPGHOME "~/.config/gnupg";

    set -x CABAL_CONFIG "~/.config/cabal/config";
    set -x LESSHISTFILE "~/.cache/less/history";
    set -x SCREENRC "~/.config/screen/config";
    set -x WWW_HOME "~/.cache/w3m";
    set -x FONTCONFIG_PATH "~/.config/fontconfig";
    set -x FONTCONFIG_FILE "~/.config/fontconfig/fonts.conf";
    set -x ALTERNATE_EDITOR "";
    set -x EDITOR "${pkgs.myEmacs}/bin/emacsclient -cn";
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
  '';
  # promptInit = ''
  #   function fish_prompt
      
  #     function _git_branch_name
  #       echo (command git rev-parse --abbrev-ref HEAD ^/dev/null)
  #     end
      
  #     function _is_git_dirty
  #       echo (command git status -s --ignore-submodules=dirty ^/dev/null)
  #     end
      
  #     function _git_short_hash
  #       echo (command git rev-parse --short HEAD ^/dev/null)
  #     end

  #     function __format_time -d "Format milliseconds to a human readable format"
  #       set -l milliseconds $argv[1]
  #       set -l seconds (math "$milliseconds / 1000 % 60")
  #       set -l minutes (math -s0 "$milliseconds / 60000 % 60")
  #       set -l hours (math -s0 "$milliseconds / 3600000 % 24")
  #       set -l days (math -s0 "$milliseconds / 86400000")
  #       set -l time
  #       set -l threshold $argv[2]
        
  #       if test $days -gt 0
  #         set time (command printf "$time%sd " $days)
  #       end
        
  #       if test $hours -gt 0
  #         set time (command printf "$time%sh " $hours)
  #       end
        
  #       if test $minutes -gt 0
  #         set time (command printf "$time%sm " $minutes)
  #       end
  #       if test $seconds -gt $threshold
  #         set time (command printf "$time%ss " $seconds)
  #       end
        
  #       echo -e $time
  #     end

  #     function _command_time
  #       set -l yellow (set_color yellow)
  #       set -l normal (set_color normal)
  #       if test -n "$CMD_DURATION"
  #         set command_duration (__format_time $CMD_DURATION 5)
  #       end

  #       echo -e "$yellow$command_duration$normal"
  #     end
      
  #     switch $USER
      
  #     case root
  #       if not set -q __fish_prompt_cwd
  #         if set -q fish_color_cwd_root
  #           set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
  #         else
  #           set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  #         end
  #       end
        
  #     case '*'
  #       if not set -q __fish_prompt_cwd
  #         set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  #       end
  #     end
      
  #     set -l green (set_color green)
  #     set -l red (set_color red)
  #     set -l ugreen (set_color -u cyan)
  #     set -l normal (set_color normal)
      
  #     set -l arrow 'λ'
  #     set -l cwd $__fish_prompt_cwd(basename (prompt_pwd))$normal
        
      
  #     if [ (_git_branch_name) ]
  #       set git_info $green(_git_branch_name)
  #       set git_hash $ugreen(_git_short_hash)$normal
  #       set git_info ":$git_info$normal [$git_hash]"
      
  #       set dirty "💔"
  #       set clean "❤️"
            
  #       if [ (_is_git_dirty) ]
  #         set git_info "$git_info$dirty "
  #       else
  #         set git_info "$git_info$clean "
  #       end
  #     end
      
  #     set -l git_info $git_info$normal
        
  #     echo -e -n -s '╭─ 正念 ' $cwd \
  #     $git_info ' ' (_command_time) \
  #     '\n╰─ ' $arrow ' '
  #   end
  # '';
}
