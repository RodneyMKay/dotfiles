{ lib, config, ... }:
let
  cfg = config.rmkmodules.neovim;
in {
  options.rmkmodules.neovim = {
    enable = lib.mkEnableOption "Enable Neovim setup";
  };

  config = lib.mkIf cfg.enable {
    # Set up nixvim
    programs.nixvim = {
      enable = true;

      # Use neovim by default
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # Use spacebar as leader key
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      # Set default options
      opts = {
        updatetime = 100; # Faster screen updates
        mouse = ""; # Disable mouse usage
        relativenumber = true; # Display relative line numbers
        number = true; # Display line numbers in general
        swapfile = false; # Don't use a swapfile
        undofile = true; # Write undo history to a file
        incsearch = true; # Incremental search
        ignorecase = true; # Ignore case sensitivity by defualt when searching
        smartcase = true; # Respect case sensitivity when a capital letter is in the search string
        scrolloff = 8; # Keep at least 8 lines between the cursor and the edges of the screen
        fileencoding = "utf-8"; # Use default encoding
        termguicolors = true; # Use 24-bit colors
        wrap = false; # Don't wrap text that gets too long

        # Tab size
        tabstop = 4;
        shiftwidth = 4;
        expandtab = true;
        autoindent = true;
      };

      # Override the indent for nix files
      files."ftplugin/nix.lua" = {
        opts = {
          shiftwidth = 2;
          tabstop = 2;
        };
      };

      # Set the colorscheme
      colorschemes.tokyonight = {
        enable = true;
        settings = {
          transparent = true;
        };
      };

      # Telescope for quick navigation
      plugins.telescope = {
        enable = true;

        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fh" = "help_tags";
          "<C-p>" = "git_files";
          "<C-f>" = "live_grep";
          "<C-b>" = "buffers";
        };

        extensions.fzf-native = {
          enable = true;
        };
      };

      # Use nerdfont icons
      plugins.web-devicons.enable = true;

      # Remember the last position in a file
      plugins.lastplace.enable = true;

      # Enable comments
      plugins.comment.enable = true;

      # LSP setup
      plugins.lspconfig.enable = true;

      lsp = {
        servers = {
          nil_ls.enable = true; # Nix
          docker_langauge_server.enable = true; # Docker (Dockerfile & compose.yaml)
          html.enable = true;
          json.enable = true;
        };

        keymaps = [
          {
            key = "gd";
            lspBufAction = "definition";
          }
          {
            key = "gD";
            lspBufAction = "references";
          }
          {
            key = "gt";
            lspBufAction = "type_definition";
          }
          {
            key = "gi";
            lspBufAction = "implementation";
          }
          {
            key = "K";
            lspBufAction = "hover";
          }
          {
            action = "<CMD>LspRestart<Enter>";
            key = "<leader>lr";
          }
        ];
      };

      # Configure completion
      plugins.cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; } # Completion from LSP
            { name = "path"; }     # Completion for file paths
            { name = "buffer"; }   # Completion for words in the current file

          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };

      plugins.lspkind.enable = true; # Use icons in completion menu
      plugins.fidget.enable = true; # LSP Status display

      # Show error messages properly
      diagnostic.settings = {
        # This shows the error message directly in the buffer
        virtual_text = {
          spacing = 4;
          prefix = "●";
        };

        # Also show signs in the gutter (the left-hand column)
        signs = true;
        underline = true;
      };

      # Add treesitter (file grammars) - this is already builtin to Neovim,
      # but the plugin adds additional integration
      plugins.treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
      };

      # Add keybinds
      keymaps = [
        # Keybinds for adding comments
        {
          mode = [ "n" ];
          key = "<C-_>";
          action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        }
        {
          mode = [ "v" "x" ];
          key = "<C-_>";
          action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        }
      ];
    };
  };
}

