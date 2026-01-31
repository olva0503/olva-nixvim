{pkgs, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      nixGrammars = true;
      settings = {
        highlight.enable = true;
        auto_install = true;
      };
    };
    treesitter-context.enable = true;
    hmts.enable = false;
  };
}
