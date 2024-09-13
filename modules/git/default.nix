{ lib, config, ... }:
let
  cfg = config.modules.git;
in {
  options.modules.git.enable = lib.mkEnableOption "Enable Git";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      userName = "RodneyMKay";
      userEmail = "36546810+RodneyMKay@users.noreply.github.com";

      extraConfig = {
        init.defaultBranch = "main";
      };

      aliases = {
        unstage = "restore --staged";
      };
    };
  };
}
