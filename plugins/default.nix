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
    barbar = {
      enable = true;
      keymaps = {
        next.key = "<TAB>";
        previous.key = "<S-TAB>";
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
    noice.enable = false; # think do I really need it

    codecompanion = {
      enable = true;
      settings = {
        adapters = {
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
    git-worktree = {
      enable = true;
      enableTelescope = true;
    };

    web-devicons.enable = true;
    markdown-preview.enable = true;

    fidget = {
      #TODO do I really need it
      enable = false;
      settings = {
        logger = {
          level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          float_precision = 0.01; # Limit the number of decimals displayed for floats
        };
        progress = {
          poll_rate = 0; # How and when to poll for progress messages
          suppress_on_insert = true; # Suppress new messages while in insert mode
          ignore_done_already = false; # Ignore new tasks that are already complete
          ignore_empty_message = false; # Ignore new tasks that don't contain a message
          clear_on_detach.__raw = ''
            function(client_id)
              local client = vim.lsp.get_client_by_id(client_id)
              return client and client.name or nil
            end
          '';

          notification_group.__raw =
            # How to get a progress message's notification group key
            ''
              function(msg) return msg.lsp_client.name end
            '';
          ignore = []; # List of LSP servers to ignore
          lsp = {
            progress_ringbuf_size = 0; # Configure the nvim's LSP progress ring buffer size
          };
          display = {
            render_limit = 16; # How many LSP messages to show at once
            done_ttl = 3; # How long a message should persist after completion
            done_icon = "✔"; # Icon shown when all LSP progress tasks are complete
            done_style = "Constant"; # Highlight group for completed LSP tasks
            progress_icon = {
              pattern = "dots";
              period = 1;
            }; # Icon shown when LSP progress tasks are in progress
            progress_style = "WarningMsg"; # Highlight group for in-progress LSP tasks
            group_style = "Title"; # Highlight group for group name (LSP server name)
            icon_style = "Question"; # Highlight group for group icons
            priority = 30; # Ordering priority for LSP notification group
            skip_history = true; # Whether progress notifications should be omitted from history
            format_message.__raw = ''
              require ("fidget.progress.display").default_format_message
            ''; # How to format a progress message
            format_annote.__raw = ''
              function (msg) return msg.title end
            ''; # How to format a progress annotation
            format_group_name.__raw = ''
              function (group) return tostring (group) end
            ''; # How to format a progress notification group's name
            overrides = {
              rust_analyzer = {
                name = "rust-analyzer";
              };
            }; # Override options from the default notification config
          };
        };
        notification = {
          poll_rate = 10; # How frequently to update and render notifications
          filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          history_size = 128; # Number of removed messages to retain in history
          override_vim_notify = true;
          redirect.__raw = ''
            function(msg, level, opts)
              if opts and opts.on_open then
                return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
              end
            end
          '';
          configs = {
            default.__raw = "require('fidget.notification').default_config";
          };

          window = {
            normal_hl = "Comment";
            winblend = 0;
            border = "none"; # none, single, double, rounded, solid, shadow
            zindex = 45;
            max_width = 0;
            max_height = 0;
            x_padding = 1;
            y_padding = 0;
            align = "bottom";
            relative = "editor";
          };
          view = {
            stack_upwards = true; # Display notification items from bottom to top
            icon_separator = " "; # Separator between group name and icon
            group_separator = "---"; # Separator between notification groups
            group_separator_hl =
              # Highlight group used for group separator
              "Comment";
          };
        };
      };
    };

    mini = {
      enable = true;

      modules = {
        ai = {
          n_lines = 500;
        };
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

    flit = {
      enable = true;
      settings = {
        labeled_modes = "nv";
        multiline = true;
      };
    };

    leap = {
      enable = true;
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

    yanky = {
      enable = true;
      enableTelescope = true;
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
        java = ["checkstyle"];
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
          gofmt.enable = true;
          htmlbeautifier.enable = true;
          # buf.enable = true;
          gofumpt.enable = true;
          sqlfluff.enable = true;
          stylua.enable = true;
          shfmt.enable = true;
        };
        diagnostics = {
          # buf.enable = true;
          # golangci_lint.enable = true;
        };
      };
    };
  };
}
