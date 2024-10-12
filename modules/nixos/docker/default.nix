{ lib, config, pkgs, username, ... }:
let
  cfg = config.modules.docker;
in {
  options.modules.docker.enable = lib.mkEnableOption "Enable Docker";

  config = lib.mkIf cfg.enable {
    # Enable docker
    virtualisation.docker = {
      enable = true;
    };

    users.extraGroups.docker.members = [
      username
    ];

    # Install docker compose
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
