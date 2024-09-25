{pkgs,...}:{
extraConfigLua = ''
      vim.keymap.set("n", "<C-a>", function()
          require("dial.map").manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
          require("dial.map").manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
          require("dial.map").manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
          require("dial.map").manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("v", "<C-a>", function()
          require("dial.map").manipulate("increment", "visual")
      end)
      vim.keymap.set("v", "<C-x>", function()
          require("dial.map").manipulate("decrement", "visual")
      end)
      vim.keymap.set("v", "g<C-a>", function()
          require("dial.map").manipulate("increment", "gvisual")
      end)
      vim.keymap.set("v", "g<C-x>", function()
          require("dial.map").manipulate("decrement", "gvisual")
      end)
      require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
      require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
      require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
      require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
      require("telescope").load_extension("lazygit")
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      require('flit').setup {
      keys = { f = 'f', F = 'F', t = 't', T = 'T' },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "v",
      -- Repeat with the trigger key itself.
      clever_repeat = true,
      multiline = true,
      -- Like `leap`s similar argument (call-specific overrides).
      -- E.g.: opts = { equivalence_classes = {} }
      opts = {}
      }
      require'lspconfig'.protols.setup{}
    '';
    extraPlugins = with pkgs.vimPlugins; [
      # NOTE: This is how you would ad a vim plugin that is not implemented in Nixvim, also see extraConfigLuaPre below
      # `neodev` configure Lua LSP for your Neovim config, runtime and plugins
      # used for completion, annotations, and signatures of Neovim apis
      # neodev-nvim
      lazygit-nvim
      flit-nvim
      dial-nvim
    ];
    extraConfigLuaPre =
      # lua
      ''
        local slow_format_filetypes = {}

        vim.api.nvim_create_user_command("FormatDisable", function(args)
           if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end, {
          desc = "Disable autoformat-on-save",
          bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
        end, {
          desc = "Re-enable autoformat-on-save",
        })
        vim.api.nvim_create_user_command("FormatToggle", function(args)
          if args.bang then
            -- Toggle formatting for current buffer
            vim.b.disable_autoformat = not vim.b.disable_autoformat
          else
            -- Toggle formatting globally
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end
        end, {
          desc = "Toggle autoformat-on-save",
          bang = true,
        })

        -- require('neodev').setup {}
      '';

  } 
