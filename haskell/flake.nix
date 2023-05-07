{
  description = "Development environment Haskell - Stack";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/release-22.05"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs.lib) optional;
        pkgs = import nixpkgs { inherit system; };

      in

      {
        devShell = pkgs.mkShell
          {
            buildInputs = with pkgs;[
              stack
              haskell-language-server
              # haskell.compiler.ghc8107
              # cabal-install
              # haskell.compiler.ghc8107
              # stack
              # haskell-language-server
              # haskellPackages.ghcup
            ];

            shellHook = ''
              echo Haskell development
            '';
          };
      }
    );
}
