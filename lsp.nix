{pkgs, ...}: {
  lsp = {
    servers = {
      protols.enable = true;
      helm_ls.enable = true;
      # rust_analayzer = {
      #   enable = true;
      # };
      elixirls.enable = true;
      sqls.enable = true;
      ts_ls.enable = true;
      gopls = {
        enable = true;
        config = {
          gopls = {
            gofumpt = true;
            codelenses = {
              gc_details = false;
              run_govulncheck = true;
              generate = true;
              test = true;
              tidy = true;
              upgrade_dependency = true;
            };
            analyses = {
              nilness = true;
              unusedparams = true;
              unusedwrite = true;
              useany = true;
            };
            hints = {
              # assignVariableTypes = true;
              # functionTypeParameters = true;
              compositeLiteralFields = true;
              compositeLiteralTypes = true;
              constantValues = true;
              # parameterNames = true;
              rageVariableTypes = true;
            };
            # usePlaceholders = true;
            # experimentalPostfixCompletions = true;
            completeUnimported = true;
            staticcheck = true;
            # semanticTokens = true;
          };
        };
      };
      golangci_lint_ls.enable = true;
      nixd.enable = true;
      harper_ls.enable = true;
      vale_ls.enable = false;
      clojure_lsp.enable = true;
      taplo.enable = true;
      eslint.enable = true;
      zls.enable = false; #TODO enable when bug fixed
      lua_ls.enable = false;
      terraformls.enable = true;
      yamlls.enable = true;
      jsonls.enable = true;
      superhtml.enable = false; #TODO enable when bug fixed
      dockerls.enable = true;
      lemminx.enable = true;
      jdtls = {
        enable = true;
        config = {
          url = "~/.config/java/Default.xml";
          profile = "custom";
        };
      };
    };
  };
}
