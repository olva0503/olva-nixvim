{pkgs, ...}: {
  imports = [
    ./autocompletion.nix
    ./dap.nix
    ./lsp.nix
    ./lsp-misc.nix
    ./testing.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  plugins = {
    flash.enable = true;
    helm.enable = true;
    barbar = {
      enable = true;
      keymaps = {
        close = {
          key = "d<TAB>";
          action = "<Cmd>BufferClose!<CR>";
        };
        closeAllButCurrent = {
          key = "D<TAB>";
        };
      };
    };
    bufferline.enable = true;
    undotree.enable = true;
    hardtime.enable = true;
    auto-session = {
      enable = true;
      settings = {
        enabled = true;
        auto_restore = true;
        auto_save = true;
      };
    };

    codecompanion = {
      enable = true;
      settings = {
        adapters.http = {
          ollama = {
            __raw = ''
              function()
                return require('codecompanion.adapters').extend('ollama', {
                    env = {
                        url = "http://127.0.0.1:11434",
                    },
                    schema = {
                        model = {
                            default = 'qwen2.5-coder:14b',
                        },
                       -- num_ctx = {
                        --     default = 32768,
                        -- },
                    },
                })
              end
            '';
          };
        };
        opts = {
          log_level = "TRACE";
          send_code = true;
          use_default_actions = true;
          use_default_prompts = true;
        };
        strategies = {
          agent = {
            adapter = "ollama";
          };
          chat = {
            adapter = "ollama";
          };
          inline = {
            adapter = "ollama";
          };
        };
      };
    };

    lazydev.enable = true;
    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {
            text = " ";
          };
          change = {
            text = " ";
          };
          delete = {
            text = " ";
          };
          untracked = {
            text = "";
          };
          topdelete = {
            text = "󱂥 ";
          };
          changedelete = {
            text = "󱂧 ";
          };
        };
      };
    };
    lazygit.enable = true;
    fugitive.enable = true;
    git-conflict.enable = true;
    git-worktree = {
      enable = true;
      enableTelescope = true;
    };

    web-devicons.enable = true;
    markdown-preview.enable = true;

    fidget = {
      #TODO do I really need it
      enable = true;
    };

    mini = {
      enable = true;

      modules = {
        ai.enable = false;
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
        };
        #TODO add alternative mapping for surround to avoid conflict with leap plugin
        surround = {
          mappings = {
            add = "gsa"; # -- Add surrounding in Normal and Visual modes
            delete = "gsd"; # -- Delete surrounding
            find = "gsf"; # -- Find surrounding (to the right)
            find_left = "gsF"; # -- Find surrounding (to the left)
            highlight = "gsh"; # -- Highlight surrounding
            replace = "gsr"; # -- Replace surrounding
            update_n_lines = "gsn"; # -- Update `n_lines`
          };
        };
      };
    };

    harpoon = {
      enable = true;
    };
    indent-blankline = {
      enable = true;
    };
    # Inserts matching pairs of parens, brackets, etc.

    oil = {
      enable = true;
      settings = {
        keymaps = {
          "<C-r>" = "actions.refresh";
          "y." = "actions.copy_entry_path";
          "g?" = "actions.show_help";
          "<CR>" = "actions.select";
          "<C-p>" = "actions.preview";
          "<C-c>" = "actions.close";
          "g." = "actions.toggle_hidden";
          "-" = "actions.parent";
          "_" = "actions.open_cwd";
          "`" = "actions.cd";
        };
        view_options = {
          show_hidden = true;
        };
        win_opts = {
        };
        skip_confirm_for_simple_edits = true;
      };
    };
    lightline = {
      enable = true;
      settings = {
        active = {
          left = [
            [
              "mode"
              "paste"
            ]
            [
              "readonly"
              "filename"
              "modified"
              "gitbranch"
            ]
          ];
          right = [
            [
              "lineinfo"
            ]
            [
              "percent"
            ]
            [
              "fileformat"
              "fileencoding"
              "filetype"
            ]
          ];
        };
        component_function = {
          gitbranch = "FugitiveHead";
        };
      };
    };

    which-key = {
      enable = true;
      settings.spec = [
        {
          __unkeyed-1 = "<leader>c";
          desc = "[C]ode";
        }
        {
          __unkeyed-1 = "<leader>d";
          desc = "[D]ebug";
        }
        {
          __unkeyed-1 = "<leader>r";
          desc = "[R]ename";
        }
        {
          __unkeyed-1 = "<leader>t";
          desc = "[T]est";
        }
        {
          __unkeyed-1 = "<leader>s";
          desc = "[S]earch";
        }
      ];
    };

    lint = {
      #TODO consoder using it
      enable = true;
      linters = {
        buf_lint = {
          append_fname = false;
          args = ["--exclude-path .idea"];
        };
      };
      lintersByFt = {
        proto = ["buf_lint"];
        # nix = ["statix"];
        lua = ["selene"];
        javascript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        typescript = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        json = ["jsonlint"];
        # java = ["checkstyle"];
        go = [
          "golangcilint"
        ];
      };
    };
    none-ls = {
      enable = true;
      sources = {
        formatting = {
          alejandra = {
            enable = true;
          };
          goimports.enable = true;
          # buf.enable = true;
          gofumpt.enable = true;
          sqlfluff.enable = true;
          stylua.enable = true;
          # shfmt.enable = true;
        };
        diagnostics = {
          codespell.enable = false;
          write_good.enable = true;
          # buf.enable = true;
          # golangci_lint.enable = true;
        };
      };
    };
  };
}
