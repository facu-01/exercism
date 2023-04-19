{
  description = "Development environment dotnet";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
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
              (with dotnetCorePackages; combinePackages [
                sdk_3_1
                sdk_7_0
              ])
            ];

            shellHook = ''
              echo dotnet environment
              dotnet --info
              dotnet restore
              dotnet tool restore
              echo all done!
            '';
          };
      }
    );
}
