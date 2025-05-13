{ lib, config, pkgs, ... }:
let
  cfg = config.modules.zsh;
in {
  options.modules.zsh.enable = lib.mkEnableOption "Enable Zsh";

  config = lib.mkIf cfg.enable {
    home.file.".config/oh-my-zsh-custom/themes" = {
      source = ./custom-themes;
      recursive = true;
    };

    home.file.".config/oh-my-zsh-custom/plugins" = {
      source = ./custom-plugins;
      recursive = true;
    };

    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;

        custom = "$HOME/.config/oh-my-zsh-custom";

        theme = "outoftheloop";
        plugins = [
          # Builtin plugins
          "git"
          "rsync"
          "cp"
          "eza"

          # Custom plugins
          "wslscripts"
          "projects"
        ];
      };
    };

    programs.eza = {
      enable = true;
      icons = "auto";
    };
  };
}
