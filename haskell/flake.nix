{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    systems.url = "github:nix-systems/default";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, systems, nix-vscode-extensions, ... }@inputs:
    let forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in {
      devShells = forEachSystem (system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in {
          default = pkgs.mkShell {

            NIX_PATH = "nixpkgs=" + pkgs.path;

            shellHook = ''
              WSLENV=$WSLENV:PATH
            '';

            buildInputs = with pkgs; [ haskell-language-server ghc stack ];

          };
        });

    };

}
