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
    };
  };
}
