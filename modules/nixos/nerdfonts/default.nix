{ lib, config, pkgs, ... }:
let
  cfg = config.rmkmodules.nerdfonts;
in {
  options.rmkmodules.nerdfonts = {
    enable = lib.mkEnableOption "Enable Nerdfont support (JetBrains Mono, currently)";
  };

  config = lib.mkIf cfg.enable {
    # Enable nerd fonts and set JetBrains Mono as default
    fonts = {
      packages = [
        pkgs.nerdfonts
      ];

      fontconfig = {
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font Mono" ];
        };
      };
    };
  };
}

