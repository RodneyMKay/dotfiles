{ lib, inputs, defaultUser, config, pkgs, ... }:
let
  cfg = config.modules.wsl;
in {
  options.modules.wsl.enable = lib.mkEnableOption "Enable WSL support in Nix";
  options.modules.wsl.docker-desktop.enable = lib.mkEnableOption "Enable Docker desktop support for WSL";

  config = lib.mkIf cfg.enable {
    # WSL settings
    wsl = {
      enable = true;
      defaultUser = defaultUser;
      docker-desktop.enable = cfg.docker-desktop.enable;
    };

    # We use this package in a WSL scenario, since some applications
    # like the Azure PowerShell Modules require an "xdg-open"
    # command to be present for authentication via OAuth2 and 
    # we just open the browser on the host windows system with this
    environment.systemPackages = [
      pkgs.xdg-utils
    ];
  };
}

