{
  description = "Development environment python";

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
              python3
              python39Packages.pytest
              python39Packages.autopep8
              python39Packages.pip
              python39Packages.ipykernel
            ];

            shellHook = ''
              echo python development
              echo python version:
              python3 --version
            '';
          };
      }
    );
}
