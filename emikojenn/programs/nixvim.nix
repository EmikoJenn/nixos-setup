{ pkgs, ... }:
{
  enable = true;
  defaultEditor = true;
  vimAlias = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavours = "mocha";
      term_colors = true;
    };
  };

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 2;
    softtabstop = 2;
  };
}
