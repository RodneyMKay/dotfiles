{ lib, config, ... }:
let
  cfg = config.rmkmodules.dynamic-fix;
in {
  options.rmkmodules.dynamic-fix = {
    enable = lib.mkEnableOption "Enable Fix for dynamically linked libraries (nix-ld)";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      libraries = [
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
      ];
    };
  };
}

