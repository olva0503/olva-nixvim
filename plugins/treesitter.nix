{
  pkgs,
  config,
  ...
}: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        rust
        java
        clojure
        elixir
        html
        javascript
        typescript
        go
        regex
        toml
        vim
        vimdoc
        xml
        helm
        yaml
      ];
      nixGrammars = true;
      settings = {
        highlight.enable = true;
        auto_install = true;
      };
    };
    treesitter-context.enable = true;
    hmts.enable = false;
    rainbow-delimiters.enable = true;
  };
}
