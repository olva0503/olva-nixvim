{pkgs, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      nixGrammars = true;
      settings = {
        highlight.enable = true;
        auto_install = true;
      };
    };
    treesitter-context.enable = true;
    treesitter-refactor = {
      enable = true;
      settings = {
        highlightDefinitions = {
          enable = true;
          # Set to false if you have an `updatetime` of ~100.
          clearOnCursorMove = false;
        };
      };
    };

    hmts.enable = true;
  };
}
