{ lib, config, inputs, ... }:
let
  cfg = config.modules.nvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.nvim.enable = lib.mkEnableOption "Enable NeoVim";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

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

      colorschemes.tokyonight = {
        enable = true;
        settings = {
          transparent = true;
        };
      };

      plugins.telescope = {
        enable = true;

        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fh" = "help_tags";
          "<C-p>" = "git_files";
          "<C-f>" = "live_grep";
        };

        extensions.fzf-native = {
          enable = true;
        };
      };

      plugins.web-devicons = {
        enable = true;
      };

      plugins.lastplace = {
        enable = true;
      };
    };

    programs.ripgrep = {
      enable = true;
    };
  };
}
