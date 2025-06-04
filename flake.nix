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
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = {
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
            ];
          };
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
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
              ];
            };
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          };
      };
    };
}
