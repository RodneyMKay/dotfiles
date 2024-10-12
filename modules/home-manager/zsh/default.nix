{ lib, config, pkgs, ... }:
let
  cfg = config.modules.zsh;
in {
  options.modules.zsh.enable = lib.mkEnableOption "Enable Zsh";

  config = lib.mkIf cfg.enable {
    home.file.".config/oh-my-zsh-custom" = {
      source = ./oh-my-zsh-custom;
      recursive = true;
    };

    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;

        custom = "$HOME/.config/oh-my-zsh-custom";

        theme = "outoftheloop";
        plugins = [
          "git"
          #"podman"
          #"docker"
          #"docker-compose"
          #"direnv"
          #"kubectl"
          #"kind"
          #"rsync"
          "cp"
          "eza"
        ];
      };
    };

    programs.eza = {
      enable = true;
      icons = true;
    };
  };
}
