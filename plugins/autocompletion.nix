{
  pkgs,
  lib,
  ...
}: {
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        signature.enabled = true;
        completion = {
          ghost_text.enabled = true;

          documentation = {
            auto_show = true;
          };
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "spell"
            # "copilot"
            # Make it too slow
            # "dictionary"
          ];

          providers = {
            # latex = {
            #   name = "Latex";
            #   module = "blink-cmp-latex";
            #   opts = {
            #     insert_command = false;
            #   };
            # };
            lsp = {
              score_offset = 100;
            };
            spell = {
              module = "blink-cmp-spell";
              name = "Spell";
              score_offset = -10;
              opts = {
              };
            };
            dictionary = {
              module = "blink-cmp-dictionary";
              name = "Dict";
              score_offset = -15;
              min_keyword_length = 4;
              # Optional configurations
              opts = {
              };
            };
            #   copilot = {
            #     async = true;
            #     module = "blink-cmp-copilot";
            #     name = "copilot";
            #     score_offset = 100;
            #   };
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
    blink-cmp-dictionary.enable = true;
    blink-cmp-copilot.enable = lib.mkDefault false;
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
    wilder = {
      enable = true;
      settings.modes = [":" "/" "?"];
    };
  };
}
