{
  enable = true;
  lfs.enable = true;

  userName = "EmikoJenn";
  userEmail = "EmikoJenn@proton.me";

  extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = true;
    alias = {
      cfg = "config --list";
      uncommit = "reset --soft HEAD^";
      logall = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };
  };

}
