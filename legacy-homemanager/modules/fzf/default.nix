{ lib, config, pkgs, ... }:
let
  cfg = config.modules.fzf;
in {
  options.modules.fzf.enable = lib.mkEnableOption "Enable fzf fuzzy finder";

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;

      enableZshIntegration = config.modules.zsh.enable;
    };
  };
}
