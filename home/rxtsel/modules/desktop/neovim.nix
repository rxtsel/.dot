{
  inputs,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
    waylandSupport = true;
    defaultEditor = true;

    # Replace with nightly for v12
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    # Treesitter grammars as plugin of nvim-treesitter
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.nix
        p.rust
        p.toml
        p.yaml
        p.markdown
        p.svelte
        p.typescript
        p.css
        p.http
        p.json5
        p.javascript
        p.tsx
        p.html
      ]))
    ];

    extraPackages = with pkgs; [
      # LSPs
      astro-language-server
      lua-language-server
      nixd
      svelte-language-server
      vtsls
      copilot-language-server

      # Formatters
      nixfmt
      stylua
      rustfmt
      biome
      prettierd

      # Neovim deps needed
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
}
