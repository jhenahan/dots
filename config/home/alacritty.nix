{ pkgs, ... }:
let
  tmuxKey = { key, mods, args }:
    {
      inherit key mods;
      command = {
        program = "${pkgs.tmux}/bin/tmux";
        inherit args;
      };
    };
in
{
  enable = true;
  settings = {
    window = {
      padding = {
        x = 10;
        y = 10;
      };
      decorations = "none";
    };
    scrolling.history = 10000;
    font.normal = {
      family = "PragmataPro";
      style = "Regular";
    };
    font.size = 12.0;
    # .oO someday
    #font.ligature = true;
    colors = {
      primary = {
        background = "#282828";
        foreground = "#ebdbb2";
      };
      normal = {
        black = "#282828";
        red = "#CC241D";
        green = "#98971A";
        yellow = "#D79921";
        blue = "#458588";
        magenta = "#B16286";
        cyan = "#689D6A";
        white = "#A89984";
      };
      bright = {
        black = "#928374";
        red = "#FB4934";
        green = "#B8BB26";
        yellow = "#FABD2F";
        blue = "#83A598";
        magenta = "#D3869B";
        cyan = "#8EC07C";
        white = "#EBDBB2";
      };
    };
    selection = {
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      save_to_clipboard = true;
    };
    shell = {
      program = "${pkgs.fish}/bin/fish";
      args = [
        "--login"
        "-c"
        "tmux new -A -s main"
      ];
    };
    key_bindings = [
      (tmuxKey {
        key = "T";
        mods = "Command";
        args = [ "new-window" "-c #{pane_current_path}" ];
      })
      (tmuxKey {
        key = "W";
        mods = "Command";
        args = [ "kill-pane" ];
      })
      (tmuxKey {
        key = "LBracket";
        mods = "Command";
        args = [ "prev" ];
      })
      (tmuxKey {
        key = "RBracket";
        mods = "Command";
        args = [ "next" ];
      })
      (tmuxKey {
        key = "Semicolon";
        mods = "Command";
        args = [ "split-window" "-v" "-c #{pane_current_path}" ];
      })
      (tmuxKey {
        key = "Apostrophe";
        mods = "Command";
        args = [ "split-window" "-h" "-c #{pane_current_path}" ];
      })
      (tmuxKey {
        key = "Left";
        mods = "Command";
        args = [ "select-pane" "-L" ];
      })
      (tmuxKey {
        key = "Right";
        mods = "Command";
        args = [ "select-pane" "-R" ];
      })
      (tmuxKey {
        key = "Up";
        mods = "Command";
        args = [ "select-pane" "-U" ];
      })
      (tmuxKey {
        key = "Down";
        mods = "Command";
        args = [ "select-pane" "-D" ];
      })
      (tmuxKey {
        key = "R";
        mods = "Command|Shift";
        args = [ "source-file" "~/.tmux.conf" ];
      })
    ];
  };
}
