{pkgs, ...}: {
  plugins = {
    rustaceanvim.enable = true;
    lsp = {
      enable = true;
      inlayHints = false;
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
        };
        extra = [
          # Jump to the definition of the word under your cusor.
          #  This is where a variable was first declared, or where a function is defined, etc.
          #  To jump back, press <C-t>.
          {
            mode = "n";
            key = "grt";
            action.__raw = "require('telescope.builtin').lsp_definitions";
            options = {
              desc = "LSP: [G]oto [D]efinition";
            };
          }
          # Find references for the word under your cursor.
          {
            mode = "n";
            key = "grr";
            action.__raw = "require('telescope.builtin').lsp_references";
            options = {
              desc = "LSP: [G]oto [R]eferences";
            };
          }
          # Jump to the implementation of the word under your cursor.
          #  Useful when your language has ways of declaring types without an actual implementation.
          {
            mode = "n";
            key = "gri";
            action.__raw = "require('telescope.builtin').lsp_implementations";
            options = {
              desc = "LSP: [G]oto [I]mplementation";
            };
          }
          # Jump to the type of the word under your cursor.
          #  Useful when you're not sure what type a variable is and you want to see
          #  the definition of its *type*, not where it was *defined*.
          {
            mode = "n";
            key = "gD";
            action.__raw = "require('telescope.builtin').lsp_type_definitions";
            options = {
              desc = "LSP: Type [D]efinition";
            };
          }
          # Fuzzy find all the symbols in your current document.
          #  Symbols are things like variables, functions, types, etc.
          {
            mode = "n";
            key = "<leader>lds";
            action.__raw = "require('telescope.builtin').lsp_document_symbols";
            options = {
              desc = "LSP: [D]ocument [S]ymbols";
            };
          }
          # Fuzzy find all the symbols in your current workspace.
          #  Similar to document symbols, except searches over your entire project.
          {
            mode = "n";
            key = "<leader>ws";
            action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
            options = {
              desc = "LSP: [W]orkspace [S]ymbols";
            };
          }
        ];
      };
      onAttach = ''
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- The following two autocommands are used to highlight references of the
        -- word under the cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      '';

      servers = {
        taplo = {
          enable = false;
        };
        cucumber_language_server = {
          enable = true;
          package = null;
        };
        nixd.enable = false;
        # nil-ls = {enable = true;};
        jsonls.enable = true;
        superhtml.enable = true;
        ltex_plus = {
          enable = true;
          package = pkgs.ltex-ls-plus;
          settings = {
            ltex = {
              enable = ["bibtex" "context" "context.tex" "html" "latex" "markdown" "org" "restructuredtext" "rsweave" "java" "go" "rust"];
              completionEnabled = true;
              language = "en";
            };
            additionalRules = {
              languageModel = "~/data/ngrams/eng/";
            };
          };
        };
        harper_ls = {
          enable = false;
        };
        vale_ls = {
          enable = false;
        };
        gopls = {
          enable = false;
          settings = {
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
        # bufls.enable = true;

        # rust_analyzer = {
        #   enable = true;
        #   installCargo = true;
        #   installRustc = true;
        # };
        sqls = {
          enable = true;
          settings = {
            connections = [
              {
                driver = "postgresql";
                dataSourceName = "host=localhost port=5432 user=admin password=admin_password dbname=main_db sslmode=disable";
              }
            ];
          };
        };

        ts_ls = {
          enable = true;
          filetypes = ["javascript" "javascriptreact" "typescript" "typescriptreact"];
          extraOptions = {
            settings = {
              javascript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true;
                  includeInlayFunctionLikeReturnTypeHints = true;
                  includeInlayFunctionParameterTypeHints = true;
                  includeInlayParameterNameHints = "all";
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                  includeInlayPropertyDeclarationTypeHints = true;
                  includeInlayVariableTypeHints = true;
                };
              };
              typescript = {
                inlayHints = {
                  includeInlayEnumMemberValueHints = true;
                  includeInlayFunctionLikeReturnTypeHints = true;
                  includeInlayFunctionParameterTypeHints = true;
                  includeInlayParameterNameHints = "all";
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                  includeInlayPropertyDeclarationTypeHints = true;
                  includeInlayVariableTypeHints = true;
                };
              };
            };
          };
        };
        eslint.enable = true;
        zls.enable = true;
        lua_ls.enable = false;
        metals.enable = true;
        terraformls.enable = true;
        pyright.enable = true;
        yamlls.enable = true;
      };
    };
    jdtls = {
      enable = true;
      # data = "~/.cache/jdtls/workspace";        Please, directly add the necessary `"-data"` flag and its argument to `plugins.jdtls.settings.cmd`
    };

    otter = {
      enable = true;
      settings = {
        handle_leading_whitespace = true;
        settings.strip_wrapping_quote_characters = [
          "'"
          "\""
          "`"
          "#"
        ];
      };
    };
  };
}
