{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    systems.url = "github:nix-systems/default";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    { self
    , nixpkgs
    , systems
    , nix-vscode-extensions
    , ...
    } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = import nixpkgs {
              system = system;
              config.allowUnfree = true;
            };
            extensions = nix-vscode-extensions.extensions.${system};
            codeWithExtensions =
              let
                inherit (pkgs) vscode-with-extensions;
                someExtensions = with (extensions.forVSCodeVersion pkgs.vscode.version).vscode-marketplace; [
                  jnoortheen.nix-ide
                  eamodio.gitlens
                  gruntfuggly.todo-tree
                  vscode-icons-team.vscode-icons
                  # usernamehw.errorlens
                  # ms-dotnettools.csdevkit
                  ionide.ionide-fsharp
                  # ms-dotnettools.csharp
                  ms-dotnettools.vscode-dotnet-runtime
                ];
              in
              (vscode-with-extensions.override {
                vscodeExtensions = someExtensions ++ [ pkgs.vscode-extensions.ms-dotnettools.csharp ];
              });
          in
          {
            default = pkgs.mkShell {

              NIX_PATH = "nixpkgs=" + pkgs.path;
              DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";

              buildInputs = with pkgs;[
                dotnet-sdk_7
              ] ++ [ codeWithExtensions ];

            };
          });

    };

}
