{ lib, inputs, defaultUser, config, pkgs, ... }:
let
  cfg = config.modules.nerdfonts;
in {
  options.modules.nerdfonts.enable = lib.mkEnableOption "Enable Nerdfont support (JetBrains Mono, currently)";

  config = lib.mkIf cfg.enable {
    # Enable nerd fonts and set JetBrains Mono as default
    fonts = {
      packages = with pkgs; [
        nerdfonts
      ];

      fontconfig = {
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font Mono" ];
        };
      };
    };
  };
}

