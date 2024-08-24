{ lib, inputs, defaultUser, config, pkgs, ... }:
let
  cfg = config.modules.docker;
in {
  options.modules.docker.enable = lib.mkEnableOption "Enable native docker implementation";

  config = lib.mkIf cfg.enable {
    # Docker settings
    virtualisation.docker.enable = true;

    users.users."${defaultUser}".extraGroups = [
      "docker"
    ];
  };
}



