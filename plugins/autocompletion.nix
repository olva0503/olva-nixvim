{pkgs, ...}: {
  plugins = {
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
      modes = [":" "/" "?"];
    };
  };
}
