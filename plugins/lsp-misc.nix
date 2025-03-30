{pkgs, ...}: {
  plugins = {
    lsp-format = {
      enable = true;
      lspServersToEnable = ["gopls" "yamlls" "taplo" "rust_analyzer" "jdtls" "ts_ls" "eslint" "superhtml"];
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
