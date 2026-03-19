{pkgs, ...}: {
  plugins = {
    parinfer-rust.enable = true;
    lsp-format = {
      enable = true;
      settings = {
        html = {
          exclude = ["harper_ls" "copilot"];
          sync = true;
        };
        nix = {
          exclude = ["harper_ls" "copilot"];
          sync = true;
          force = true;
        };
        rust = {
          exclude = ["harper_ls" "copilot"];
          sync = true;
        };
        go = {
          exclude = ["harper_ls" "copilot"];
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
      settings = {
        lightbulb = {
          debounce = 500;
          sign = false;
        };
        rename.autoSave = false;
      };
    };
  };
}
