{ lib, config, ... }:
let
  cfg = config.modules.git;
in {
  options.modules.git.enable = lib.mkEnableOption "Enable Git";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      userName = "RodneyMKay";

      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store --file /run/secrets/git_credentials";
      };

      aliases = {
        unstage = "restore --staged";
        pushnew = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
        amend = "commit -a --amend --no-edit";
      };
    };
  };
}
