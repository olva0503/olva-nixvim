{pkgs, ...}: {
  imports = [
    ./dap.nix
    ./lsp.nix
    ./lsp-misc.nix
    ./testing.nix
    ./treesitter.nix
  ];

  plugins = {
    web-devicons.enable = true;
    markdown-preview.enable = true;
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
    auto-session = {
      enable = true;
      settings = {
        enabled = true;
        auto_restore = true;
        auto_save = true;
      };
    };
    lazygit.enable = true;
    noice.enable = true; # think do I really need it
    fugitive.enable = true;
    git-worktree = {
      enable = true;
      enableTelescope = true;
    };
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
          sqlformat.enable = false;
          stylua.enable = true;
          shfmt.enable = true;
        };
        diagnostics = {
          # buf.enable = true;
          # golangci_lint.enable = true;
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

      keymapsSilent = true;

      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<C-e>";
        navFile = {
          "1" = "<leader>1";
          "2" = "<leader>2";
          "3" = "<leader>3";
          "4" = "<leader>4";
          "5" = "<leader>5";
          "6" = "<leader>6";
          "7" = "<leader>7";
        };
      };
    };
    leap = {
      enable = true;
    };
    indent-blankline = {
      enable = true;
    };
    # Inserts matching pairs of parens, brackets, etc.
    nvim-autopairs = {
      enable = true;
      settings.fast_wrap.chars = [
        "{"
        "["
        "("
        "'"
        "\""
      ];
    };
    blink-cmp = {
      enable = true;
      settings = {
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "spell"
            # "dictionary" #slowdowns
          ];

          providers = {
            spell = {
              module = "blink-cmp-spell";
              name = "Spell";
              score_offset = 10;
              opts = {
              };
            };
            dictionary = {
              module = "blink-cmp-dictionary";
              name = "Dict";
              score_offset = 100;
              min_keyword_length = 3;
              # Optional configurations
              opts = {
              };
            };
          };
        };
        keymap = {
          "<C-b>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-e>" = [
            "hide"
          ];
          "<C-f>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<Tab>" = [
            "select_next"
            "fallback"
          ];
          "<S-Tab>" = [
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "<C-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<Enter>" = [
            "select_and_accept"
            "fallback"
          ];
          "<C-p>" = [
            "snippet_backward"
            "fallback"
          ];
          "<C-n>" = [
            "snippet_forward"
            "fallback"
          ];
        };
      };
    };
    blink-cmp-spell.enable = true;
    # blink-cmp-dictionary.enable = true;
    wilder = {
      enable = true;
      modes = [":" "/" "?"];
    };
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
    telescope = {
      enable = true;
      extensions = {
        file-browser = {
          enable = true;
        };
        fzf-native = {
          enable = true;
        };
        ui-select = {
          settings = {
            specific_opts = {
              codeactions = true;
            };
          };
        };
        undo = {
          enable = true;
        };
      };
      settings = {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "top";
            };
          };
          sorting_strategy = "ascending";
        };
        pickers = {
          colorscheme = {
            enable_preview = true;
          };
          live_grep = {
            additional_args = ''
              function(_)
                return { "--hidden" }
               end
            '';
          };
        };
      };
      keymaps = {
        "<leader>sh" = {
          mode = "n";
          action = "help_tags";
          options = {
            desc = "[S]earch [H]elp";
          };
        };
        "<leader>sk" = {
          mode = "n";
          action = "keymaps";
          options = {
            desc = "[S]earch [K]eymaps";
          };
        };
        "<leader>ss" = {
          mode = "n";
          action = "builtin";
          options = {
            desc = "[S]earch [S]elect Telescope";
          };
        };
        "<leader>sw" = {
          mode = "n";
          action = "grep_string";
          options = {
            desc = "[S]earch current [W]ord";
          };
        };
        "<leader>sg" = {
          mode = "n";
          action = "live_grep";
          options = {
            desc = "[S]earch by [G]rep";
          };
        };
        "<leader>sd" = {
          mode = "n";
          action = "diagnostics";
          options = {
            desc = "[S]earch [D]iagnostics";
          };
        };
        "<leader>sr" = {
          mode = "n";
          action = "resume";
          options = {
            desc = "[S]earch [ ]esume";
          };
        };
        "<leader>sf" = {
          mode = "n";
          action = "oldfiles";
          options = {
            desc = "[S]earch Recent Files ('.' for repeat)";
          };
        };
        "<leader><leader>" = {
          mode = "n";
          action = "buffers";
          options = {
            desc = "[ ] Find existing buffers";
          };
        };
        "<leader>:" = {
          action = "command_history";
          options = {
            desc = "Command History";
          };
        };
        "<leader>b" = {
          action = "buffers";
          options = {
            desc = "+buffer";
          };
        };
        "<leader>ff" = {
          action = "find_files";
          options = {
            desc = "Find project files";
          };
        };
        "<C-p>" = {
          action = "git_files";
          options = {
            desc = "Search git files";
          };
        };
        "<leader>gc" = {
          action = "git_commits";
          options = {
            desc = "Commits";
          };
        };
        "<leader>gs" = {
          action = "git_status";
          options = {
            desc = "Status";
          };
        };
        "<leader>sa" = {
          action = "autocommands";
          options = {
            desc = "Auto Commands";
          };
        };
        "<leader>sb" = {
          action = "current_buffer_fuzzy_find";
          options = {
            desc = "Buffer";
          };
        };
        "<leader>sC" = {
          action = "commands";
          options = {
            desc = "Commands";
          };
        };
        "<leader>sD" = {
          action = "diagnostics";
          options = {
            desc = "Workspace diagnostics";
          };
        };
        "<leader>sH" = {
          action = "highlights";
          options = {
            desc = "Search Highlight Groups";
          };
        };

        "<leader>sM" = {
          action = "man_pages";
          options = {
            desc = "Man pages";
          };
        };
        "<leader>sm" = {
          action = "marks";
          options = {
            desc = "Jump to Mark";
          };
        };
        "<leader>so" = {
          action = "vim_options";
          options = {
            desc = "Options";
          };
        };
        "<leader>sR" = {
          action = "resume";
          options = {
            desc = "Resume";
          };
        };
        "<leader>uC" = {
          action = "colorscheme";
          options = {
            desc = "Colorscheme preview";
          };
        };
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
        keys = {
          F = "F";
          T = "T";
          f = "f";
          t = "t";
        };
        labeled_modes = "nv";
        multiline = true;
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

    yanky = {
      enable = true;
      enableTelescope = true;
    };
    hmts.enable = true;

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
  };
}
