{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user.name = "EmikoJenn";
      user.email = "EmikoJenn@proton.me";

      init.defaultBranch = "main";
      pull.rebase = true;

      alias = {
        cfg = "config --list";
        uncommit = "reset --soft HEAD^";
        logall = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      };
    };
  };
}
