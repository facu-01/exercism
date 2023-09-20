{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };


  outputs =
    { self
    , nixpkgs
    , devenv
    , systems
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

          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/

                  packages = [
                    pkgs.jetbrains.idea-ultimate
                    # pkgs.scala_2_12
                    # pkgs.jdk8
                    # pkgs.sbt
                  ];

                  languages.scala = {
                    enable = true;
                    # package = pkgs.scala_2_12;
                  };

                  # languages.java = {
                  #   enable = true;
                  #   jdk.package = pkgs.jdk8;
                  # };



                  enterShell = ''
                    alias idea-ult='idea-ultimate > /dev/null 2>&1 &'
                  '';
                }
              ];
            };
          });
    };
}
