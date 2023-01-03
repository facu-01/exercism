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
              echo getting everithing ready ...
              
              if grep -q "nix" stack.yaml 
              then echo "nix enabled on stack.yaml!" 
              else echo "enabling nix on stack.yaml..." && echo "nix:
                enable: true" >> stack.yaml 
              fi
              
              stack ghc -- --version
              echo all done!
            '';
          };
      }
    );
}
