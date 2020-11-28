{
  enable = true;
  settings = {
    format = "┌─乱 $all";
    character = {
      format = "└─$symbol ";
      success_symbol = "[λ](green)";
      error_symbol = "[✘](red)";
    };
    git_commit = {
      only_detached = false;
      tag_disabled = false;
    };
    status = {
      disabled = false;
      format = "│ [$status]($style)\n";
    };
    terraform = {
      format = "via [$symbol$version $workspace]($style) ";
    };
    time = {
      disabled = false;
      format = "│ [$time]($style)\n";
    };
  };
}
