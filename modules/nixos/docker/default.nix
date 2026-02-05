{ lib, defaultUser, config, ... }:
let
  cfg = config.rmkmodules.docker;
in {
  options.rmkmodules.docker = {
    enable = lib.mkEnableOption "Enable native docker implementation";
  };

  config = lib.mkIf cfg.enable {
    # Docker settings
    virtualisation.docker.enable = true;

    users.users."${defaultUser}".extraGroups = [
      "docker"
    ];
  };
}



