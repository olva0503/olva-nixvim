{pkgs, ...}: {
  plugins = {
    lsp-format = {
      enable = true;
      settings = {
        html = {
          sync = true;
        };
        nix = {
          sync = true;
        };
        rust = {
          sync = true;
        };
        go = {
          sync = true;
        };
      };

      # sql = {
      # exclude = ["sqls"];
      # };
    };
    lsp-status.enable = true; #TODO consider using it
    lspsaga = {
      enable = true;
      lightbulb = {
        debounce = 500;
        sign = false;
      };
      rename.autoSave = false;
    };
  };
}
