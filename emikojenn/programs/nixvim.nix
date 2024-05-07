{ pkgs };
{
  enable = true;
  defaultRditor = true;
  vimAlias = true

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 2;
    softtabstop = 2;
  };

  auto-save = {
    enable = true;
    triggerEvents = [
      "FocusLost"
      "BufLeave"
    ];
  };

  telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "git_files";
        "<leader>fa" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";

        "<leader>sr" = "lsp_references";
        "<leader>sd" = "lsp_definitions";
        "<leader>si" = "lsp_implementations";
        "<leader>ss" = "lsp_document_symbols";
        "<leader>sw" = "lsp_workspace_symbols";
        "<leader>st" = "lsp_type_definitions";
        "<leader>sh" = "diagnostics";
      };
    };

    treesitter = {
      enable = true;
      indent = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      nixvimInjections = true;
    };
}
