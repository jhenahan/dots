{
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
}
