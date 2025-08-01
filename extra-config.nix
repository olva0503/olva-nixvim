{pkgs, ...}: {
  extraConfigLua = ''

    require('dap').listeners.after.event_initialized['dapui_config'] = require('dapui').open
    require('dap').listeners.before.event_terminated['dapui_config'] = require('dapui').close
    require('dap').listeners.before.event_exited['dapui_config'] = require('dapui').close
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

    require'lspconfig'.protols.setup{}

  '';
  extraPlugins = with pkgs.vimPlugins; [
    # NOTE: This is how you would ad a vim plugin that is not implemented in Nixvim, also see extraConfigLuaPre below
    # used for completion, annotations, and signatures of Neovim apis
    (pkgs.vimUtils.buildVimPlugin {
      name = "enhanced golang grammar";
      src = pkgs.fetchFromGitHub {
        owner = "hexdigest";
        repo = "go-enhanced-treesitter.nvim";
        rev = "6fb2f20b70ed2ecdd221f9ca4bfc5084dfae22b0";
        hash = "sha256-z9hfqqFOSKQW34rvWi+WiyIknxfoQsKssvUn5h66FlI=";
      };
    })
  ];
  extraConfigLuaPre =
    # lua
    ''
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

    '';
}
