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
        black   = "#282828";
        red     = "#CC241D";
        green   = "#98971A";
        yellow  = "#D79921";
        blue    = "#458588";
        magenta = "#B16286";
        cyan    = "#689D6A";
        white   = "#A89984";
      };
      bright = {
        black   = "#928374";
        red     = "#FB4934";
        green   = "#B8BB26";
        yellow  = "#FABD2F";
        blue    = "#83A598";
        magenta = "#D3869B";
        cyan    = "#8EC07C";
        white   = "#EBDBB2";
      };
    };
    selection = {
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      save_to_clipboard = true;
    };
  };
}
