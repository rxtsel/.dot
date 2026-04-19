{inputs, ...}: {
  flake.modules.nixos.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      config.pkgs = pkgs;
      config.extraPackages = with pkgs; [
        # LSPs
        astro-language-server
        lua-language-server
        nixd
        svelte-language-server
        vtsls
        copilot-language-server
        tailwindcss-language-server
        vscode-css-languageserver

        # Formatters
        alejandra
        stylua
        rustfmt
        biome
        prettierd

        # Neovim deps
        tree-sitter
        imagemagick
        curl
        jq
        ripgrep
        fd
        wl-clipboard
        gcc
        lsof
      ];
    };
  };
}
