{
  description = "Go development environment with custom Go tools";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/5629520edecb69630a3f4d17d3d33fc96c13f6fe"; # Commit with Go 1.23.0
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
  }: let
    # Systems supported
    allSystems = [
      "x86_64-linux"    # 64-bit Intel/AMD Linux
      "aarch64-linux"   # 64-bit ARM Linux
      "x86_64-darwin"   # 64-bit Intel macOS
      "aarch64-darwin"  # 64-bit ARM macOS
    ];

    # Helper to provide system-specific attributes
    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs { inherit system; };
        });
  in {
    # Development environment output
    devShells = forAllSystems ({ pkgs }: {
      default = pkgs.mkShell {
        packages = [
          pkgs.go
          pkgs.air
          pkgs.goose
          pkgs.sqlc
          pkgs.oapi-codegen
          pkgs.natscli
        ];

        shellHook = ''
          echo "Development environment ready. Go and Go tools installed."
        '';

        # Environment Variable
        PORT=8888;
      };
    });
  };
}
