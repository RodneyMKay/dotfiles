{ lib, config, ... }:
let
  cfg = config.modules.nvim;
in {
  options.modules.nvim.enable = lib.mkEnableOption "Enable NeoVim";

  config = lib.mkIf cfg.enable {
    home.file.".config/nvim/init.lua".source = ./init.lua;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
