{pkgs, ...}: {
  plugins = {
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
    };
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
