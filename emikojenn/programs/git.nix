{
  enable = true;
  userName = "EmikoJenn";
  userEmail = "TabrisSoreth@gmail.com";
  signing = {
    key = "";
    signByDefault = true;
  };
  extraConfig = {
    #pull.rebase = true;
    init.defaultBranch = "main";
    #merge = {
      #tool = "nvim-mergetool";
      #conflictstyle = "diff3";
    #};
    #mergetool.nvim-mergetool = {
      #cmd = ''
        #nvim -f -c "MergetoolStart" "$MERGED" "$BASE" "$LOCAL" "$REMOTE"
      #'';
      trustExitCode = true;
    };
    #mergetool.prompt = false;
  };
}
