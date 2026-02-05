{ lib, config, pkgs, ... }:
let
  cfg = config.rmkmodules.terraform;
in {
  options.rmkmodules.terraform = {
    enable = lib.mkEnableOption "Enable Terraform/Terragrunt/OpenTofu development tooling";
  };

  config = lib.mkIf cfg.enable {
    # Include packages
    environment.systemPackages = with pkgs; [
      tenv
      terraform-docs
      powershell
      azure-cli
      spacectl
      gnumake
      python313
    ];

    environment.sessionVariables = {
      TENV_AUTO_INSTALL = "true"; # Install required version
    };

    programs.zsh = {
      shellAliases = {
        # e.g. ls = "eza";
      };
    };
  };
}
