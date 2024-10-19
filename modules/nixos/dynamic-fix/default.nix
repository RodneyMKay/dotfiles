{ lib, config, pkgs, ... }:
let
  cfg = config.modules.dynamic-fix;
in {
  options.modules.dynamic-fix.enable = lib.mkEnableOption "Enable Fix for dynamically linked libraries (nix-ld)";

  config = lib.mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
      ];
    };
  };
}

