{pkgs, ...}: {
  plugins = {
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
  };
}
