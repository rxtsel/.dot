{ inputs, pkgs, ... }:

{
  # Import NVF Home Manager defaults
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      # Override plugins
      pluginOverrides = {
        solarized-osaka = pkgs.fetchFromGitHub {
          owner = "craftzdog";
          repo = "solarized-osaka.nvim";
          rev = "main";
          hash = "sha256-bEHBXw7ufHOrqw/frbBSaLv7Kr8F6BK2B7E83dKAsHk=";
        };
      };

      # General Vim settings
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      searchCase = "ignore";

      # LSP
      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = true;
      };

      # Treesitter configuration
      treesitter = {
        enable = true;
        highlight.enable = true;
        addDefaultGrammars = true;
        fold = true;
      };

      # Clipboard settings
      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };

      # Color theme
      theme = {
        enable = true;
        name = "solarized-osaka";
        transparent = true;
      };

      # AI
      assistant.copilot = {
        enable = true;

        setupOpts = {
          suggestion = {
            enabled = true;
            auto_trigger = true;
          };

          panel = {
            enabled = true;
            layout.position = "right";
          };
        };

        mappings.suggestion = {
          accept = "<A-l>";
          next = "<C-n>";
          prev = "<C-p>";
          dismiss = "<C-e>";
        };

        mappings.panel = {
          open = "<leader>cp";
          accept = "<CR>";
          jumpNext = "]]";
          jumpPrev = "[[";
          refresh = "gr";
        };
      };

      # Autocompletion plugin key mappings
      autocomplete.blink-cmp = {
        enable = true;
        mappings = {
          confirm = "<CR>";
          next = "<C-n>";
          previous = "<C-p>";
          close = "<C-e>";
          scrollDocsUp = "<C-u>";
          scrollDocsDown = "<C-d>";
        };
      };

      # Plugins
      git.enable = true;
      notes.todo-comments.enable = true;
      presence.neocord.enable = true;
      notify.nvim-notify.enable = true;
      ui.colorizer.enable = true;

      # Editor options
      options = {
        signcolumn = "yes";
        tabstop = 2;
        shiftwidth = 2;
        number = true;
        relativenumber = true;
        wrap = false;
        swapfile = false;
        autoindent = true;
        smartindent = true;
        hlsearch = true;
        backup = false;
        showcmd = false;
        cmdheight = 1;
        laststatus = 3;
        expandtab = true;
        scrolloff = 10;
        inccommand = "split";
        ignorecase = true;
        smarttab = true;
        breakindent = true;
        splitbelow = true;
        splitright = true;
        splitkeep = "cursor";
        mouse = "nvc";
        conceallevel = 0;
        foldcolumn = "1";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
        cursorline = true;
      };

      # Language-specific settings
      languages = {
        rust = {
          enable = true;
          treesitter.enable = true;
        };
        nix.enable = true;
        astro = {
          enable = true;
          treesitter.enable = true;
        };
        lua.enable = true;
        css = {
          enable = true;
          treesitter.enable = true;
        };
        svelte = {
          enable = true;
          treesitter.enable = true;
        };
        tailwind.enable = true;
        ts = {
          enable = true;
          treesitter.enable = true;
          extensions.ts-error-translator.enable = true;
        };
        markdown = {
          enable = true;
          extensions.markview-nvim.enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
      };

      # Utilities and Mini plugins
      utility.oil-nvim = {
        enable = true;
        gitStatus.enable = true;
      };
      mini.pick.enable = true;
      mini.pairs.enable = true;
      mini.surround.enable = true;
      statusline.lualine.enable = true;
      binds.whichKey = {
        enable = true;
        setupOpts.preset = "helix";
      };

      # Global settings
      globals.mapleader = " ";

      # Terminal integration
      terminal.toggleterm = {
        enable = true;
        lazygit = {
          enable = true;
        };
      };

      # Key mappings
      keymaps = [
        # Save / quit
        {
          mode = "n";
          key = "<C-s>";
          action = "<CMD>w<CR>";
          desc = "Save file";
        }
        {
          mode = "n";
          key = "<leader>q";
          action = "<CMD>q<CR>";
          desc = "Quit";
        }

        # Explorer / pickers
        {
          mode = "n";
          key = "<leader>e";
          action = "<CMD>Oil<CR>";
          desc = "Open Oil";
        }
        {
          mode = "n";
          key = ";f";
          action = "<CMD>Pick files<CR>";
          desc = "Pick files";
        }
        {
          mode = "n";
          key = ";r";
          action = "<CMD>Pick grep_live<CR>";
          desc = "Pick grep";
        }
        {
          mode = "n";
          key = "\\\\";
          action = "<CMD>Pick buffers<CR>";
          desc = "Pick buffers";
        }
        {
          mode = "n";
          key = ";h";
          action = "<CMD>Pick help<CR>";
          desc = "Pick help";
        }

        # Increment / decrement
        {
          mode = "n";
          key = "+";
          action = "<C-a>";
          desc = "Increment";
        }
        {
          mode = "n";
          key = "-";
          action = "<C-x>";
          desc = "Decrement";
        }

        # Tabs
        {
          mode = "n";
          key = "te";
          action = "<CMD>tabedit<CR>";
          desc = "New tab";
        }
        {
          mode = "n";
          key = "<Tab>";
          action = "<CMD>tabnext<CR>";
          desc = "Next tab";
        }
        {
          mode = "n";
          key = "<S-Tab>";
          action = "<CMD>tabprev<CR>";
          desc = "Previous tab";
        }

        # Splits
        {
          mode = "n";
          key = "ss";
          action = "<CMD>split<CR>";
          desc = "Horizontal split";
        }
        {
          mode = "n";
          key = "sv";
          action = "<CMD>vsplit<CR>";
          desc = "Vertical split";
        }

        # Move focus
        {
          mode = "n";
          key = "sh";
          action = "<C-w>h";
          desc = "Move left";
        }
        {
          mode = "n";
          key = "sk";
          action = "<C-w>k";
          desc = "Move up";
        }
        {
          mode = "n";
          key = "sj";
          action = "<C-w>j";
          desc = "Move down";
        }
        {
          mode = "n";
          key = "sl";
          action = "<C-w>l";
          desc = "Move right";
        }

        # Resize splits
        {
          mode = "n";
          key = "<C-w><left>";
          action = "<C-w><";
          desc = "Resize left";
        }
        {
          mode = "n";
          key = "<C-w><right>";
          action = "<C-w>>";
          desc = "Resize right";
        }
        {
          mode = "n";
          key = "<C-w><up>";
          action = "<C-w>+";
          desc = "Resize up";
        }
        {
          mode = "n";
          key = "<C-w><down>";
          action = "<C-w>-";
          desc = "Resize down";
        }

        # Visual indent (stay selected)
        {
          mode = "v";
          key = "<";
          action = "<gv";
          desc = "Indent left";
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          desc = "Indent right";
        }
        {
          mode = "n";
          key = "<Esc>";
          action = "<CMD>nohlsearch<CR>";
          desc = "Clear search highlight";
        }
      ];
    };
  };
}
