{pkgs, ...}: {
  plugins = {
    lsp-format = {
      enable = true;
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
