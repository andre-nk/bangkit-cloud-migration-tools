{
  description = "DevOps development environment";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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
          pkgs.opentofu
          pkgs.terragrunt
        ];

        shellHook = ''
          alias tf=tofu
          alias tg=terragrunt

          PROJECT_ROOT=$(git rev-parse --show-toplevel || pwd)

          if [ -f $PROJECT_ROOT/.env ]; then
            echo "Export environment variables from .env file"
            source $PROJECT_ROOT/.env
          else
            cat <<EOF > $PROJECT_ROOT/.env
  export AUTHENTIK_URL=https://<AUTHENTIK_URL>
  export AUTHENTIK_TOKEN=<AUTHENTIK_TOKEN>
  export AUTHENTIK_INSECURE=false
  EOF
            echo "New .env created in $PROJECT_ROOT"
            echo "You need to add the secret in .env file, don't forget to 'source .env' to load the environment variables."
          fi
          echo "Development environment ready. OpenTofu and Terragrunt installed."
        '';

      };
    });
  };
}
