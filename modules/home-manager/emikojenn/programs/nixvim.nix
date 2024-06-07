{ pkgs, ... }:
{
  enable = true;
  defaultEditor = true;
  vimAlias = true;

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 2;
    softtabstop = 2;
  };
}
