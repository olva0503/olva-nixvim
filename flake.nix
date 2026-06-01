{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs = inputs @ {flake-parts, ...}: let
    nixvimFlakeModule = {
      perSystem = {system, ...}: let
        nixvim = inputs.nixvim.legacyPackages.${system};
      in {
        packages.default = nixvim.makeNixvimWithModule {
          module = {
            imports = [
              ./keymaps.nix
              ./extra-config.nix
              ./settings.nix
              ./plugins
              ./autocmd.nix
              ./lsp.nix
            ];
          };
        };
      };
      flake.lib.makeNixvimWithExtra = system: extraConfig:
        inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          module = {
            imports = [
              extraConfig
              ./keymaps.nix
              ./extra-config.nix
              ./settings.nix
              ./plugins
              ./autocmd.nix
              ./lsp.nix
            ];
          };
        };
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      nixpkgs.config.allowUnfreePredicate = true;
      imports = [nixvimFlakeModule];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin" # ← added macOS ARM
      ];

      flake.flakeModules.default = nixvimFlakeModule;
    };
}
