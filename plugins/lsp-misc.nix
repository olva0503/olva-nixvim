{pkgs, ...}: {
  plugins = {
    lsp-format = {
      enable = true;
      settings = {
        html = {
          exclude = ["harper_ls"];
          sync = true;
        };
        nix = {
          exclude = ["harper_ls"];
          sync = true;
          force = true;
        };
        rust = {
          exclude = ["harper_ls"];
          sync = true;
        };
        go = {
          exclude = ["harper_ls"];
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
