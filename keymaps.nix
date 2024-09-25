{
    keymaps = [
      # Press 'H', 'L' to jump to start/end of a line (first/last character)
      {
        mode = ["n" "v"];
        key = "L";
        action = "$";
      }
      {
        mode = ["n"];
        key = "H";
        action = "^";
      }
      {
        mode = "n";
        key = "<leader>uid";
        action.__raw = ''
          function()
             local uuid = vim.fn.system("uuidgen"):gsub("\n", "")
             uuid = string.lower(uuid)
             vim.api.nvim_put({uuid}, "", true, true)
          end
        '';
        options = {
          desc = "Put UUID";
        };
      }
      {
        mode = ["n"];
        key = "<C-s>";
        action = "<cmd>w<cr>";
        options = {desc = "Save buffer";};
      }
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>MarkdownPreview<cr>";
        options = {
          desc = "Markdown Preview";
        };
      }
      {
        mode = ["n" "t"];
        key = "<C-n>";
        action = "<cmd>FloatermToggle<cr>";
        options = {
          silent = true;
          desc = "Terminal";
        };
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit (root dir)";
        };
      }
      {
        mode = ["n"];
        key = "<leader>glb";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options = {
          desc = "Blame current line";
        };
      }
      {
        mode = ["n"];
        key = "<leader>e";
        action = "<cmd>Oil<cr>";
        options = {desc = "Open file tree";};
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Telescope file_browser<cr>";
        options = {
          desc = "File browser";
        };
      }
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>UndotreeToggle<cr>";
        options = {
          desc = "Toggle undotree";
        };
      }
      {
        mode = "n";
        key = "<leader>fE";
        action = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>";
        options = {
          desc = "File browser";
        };
      }
      {
        mode = "n";
        key = "<C-t>";
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep({
              default_text="TODO",
              initial_mode="normal"
            })
          end
        '';
        options.silent = true;
      }

      # Toggle to see last session result. Without this, you can't see session output
      # in case of unhandled exception.
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Git blame<CR>";
        options = {
          desc = "Enbale git blame";
        };
      }
      #DAP
      {
        mode = "n";
        key = "<leader>dB";
        action = "
        <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
      ";
        options = {
          silent = true;
          desc = "Breakpoint Condition";
        };
      }
      {
        mode = "n";
        key = "<leader>db";
        action = ":DapToggleBreakpoint<cr>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<cr>";
        options = {
          silent = true;
          desc = "Continue";
        };
      }
      {
        mode = "n";
        key = "<leader>da";
        action = "<cmd>lua require('dap').continue({ before = get_args })<cr>";
        options = {
          silent = true;
          desc = "Run with Args";
        };
      }
      {
        mode = "n";
        key = "<leader>dC";
        action = "<cmd>lua require('dap').run_to_cursor()<cr>";
        options = {
          silent = true;
          desc = "Run to cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>dg";
        action = "<cmd>lua require('dap').goto_()<cr>";
        options = {
          silent = true;
          desc = "Go to line (no execute)";
        };
      }
      {
        mode = "n";
        key = "<leader>di";
        action = ":DapStepInto<cr>";
        options = {
          silent = true;
          desc = "Step into";
        };
      }
      {
        mode = "n";
        key = "<leader>dj";
        action = "
        <cmd>lua require('dap').down()<cr>
      ";
        options = {
          silent = true;
          desc = "Down";
        };
      }
      {
        mode = "n";
        key = "<leader>dk";
        action = "<cmd>lua require('dap').up()<cr>";
        options = {
          silent = true;
          desc = "Up";
        };
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua require('dap').run_last()<cr>";
        options = {
          silent = true;
          desc = "Run Last";
        };
      }
      {
        mode = "n";
        key = "<leader>do";
        action = ":DapStepOut<cr>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = ":DapStepOver<cr>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<leader>dp";
        action = "<cmd>lua require('dap').pause()<cr>";
        options = {
          silent = true;
          desc = "Pause";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = ":DapToggleRepl<cr>";
        options = {
          silent = true;
          desc = "Toggle REPL";
        };
      }
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>lua require('dap').session()<cr>";
        options = {
          silent = true;
          desc = "Session";
        };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = ":DapTerminate<cr>";
        options = {
          silent = true;
          desc = "Terminate";
        };
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<cr>";
        options = {
          silent = true;
          desc = "Dap UI";
        };
      }
      {
        mode = "n";
        key = "<leader>dw";
        action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
        options = {
          silent = true;
          desc = "Widgets";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>de";
        action = "<cmd>lua require('dapui').eval()<cr>";
        options = {
          silent = true;
          desc = "Eval";
        };
      }

      #TESTS
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>";
        options = {
          desc = "Run File";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tT";
        action = "<cmd>lua require('neotest').run.run(vim.uv.cwd())<CR>";
        options = {
          desc = "Run All Test Files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tr";
        action = "<cmd>lua require('neotest').run.run()<CR>";
        options = {
          desc = "Run Nearest";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>";
        options = {
          desc = "Run Nearest with debugger";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ts";
        action = "<cmd>lua require('neotest').summary.toggle()<CR>";
        options = {
          desc = "Toggle Summary";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>lua require('neotest').output.open{ enter = true, auto_close = true }<CR>";
        options = {
          desc = "Show Output";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tO";
        action = "<cmd>lua require('neotest').output_panel.toggle()<CR>";
        options = {
          desc = "Toggle Output Panel";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tS";
        action = "<cmd>lua require('neotest').run.stop()<CR>";
        options = {
          desc = "Stop";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tb";
        action.__raw = ''
          function()
           require('dap').run({
             type = "go",
             name = "TestAllSuites",
             request = "launch",
             mode = "test",
             program = "./tests",
             args = { "-test.run", "TestAllSuites", "-godog.tags", "@wip"},
           })
           end
        '';
        options = {
          desc = "Debug bdd test";
        };
      }
      ### GIT signs
      {
        mode = "n";
        key = "<leader>hs";
        action = "<cmd>Gitsigns stage_hunk<cr>";
        options = {
          desc = "Stage hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>hr";
        action = "<cmd>Gitsigns reset_hunk<cr>";
        options = {
          desc = "Reset hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>ph";
        action = "<cmd>Gitsigns preview_hunk<cr>";
        options = {
          desc = "Preview hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>hdt";
        action = "<cmd>Gvdiffsplit!<cr>";
        options = {
          desc = "Diff this";
        };
      }
      {
        mode = "n";
        key = "ga";
        action = "<cmd>diffget //2<cr>";
        options = {
          desc = "Accept left";
        };
      }
      {
        mode = "n";
        key = "gl";
        action = "<cmd>diffget //3<cr>";
        options = {
          desc = "Accept right";
        };
      }
    ];
    highlight.Todo = {
      fg = "Blue";
      bg = "Yellow";
    };

    match.TODO = "TODO";
}
