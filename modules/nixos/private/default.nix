{
  lib,
  config,
  ...
}: let
  privateFlake = builtins.getFlake "git+file:/home/rodney/dotfiles/private";
  cfg = config.rmkmodules.private;
in {
  options.rmkmodules.private = {
    enable = lib.mkEnableOption "Enable integration of private dotfiles";
  };

  imports = [
    privateFlake.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    rmkmodules.ssh.enable = true;
    rmkmodules.secrets.enable = true;
  };
}
