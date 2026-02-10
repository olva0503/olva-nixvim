{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin" # ← added macOS ARM
      ];
      perSystem = {
        self',
        pkgs,
        system,
        ...
      }: let
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
      flake = {
        lib.makeNixvimWithExtra = system: extraConfig:
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
    };
}
