{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    formatter = pkgs.writeShellApplication {
      name = "fmt";
      runtimeInputs = [
        pkgs.treefmt
        pkgs.alejandra
      ];
      text = ''
        exec treefmt "$@"
      '';
    };

    checks.format = pkgs.runCommand "format-check" {} ''
      cd ${inputs.self}
      ${pkgs.treefmt}/bin/treefmt --fail-on-change
      touch "$out"
    '';

    devShells.default = pkgs.mkShell {
      packages = [
        pkgs.treefmt
        pkgs.alejandra
        pkgs.pre-commit
      ];

      shellHook = ''
        if [ -f .pre-commit-config.yaml ]; then
          ${pkgs.pre-commit}/bin/pre-commit install --install-hooks --hook-type pre-commit >/dev/null 2>&1 || true
        fi
      '';
    };
  };
}
