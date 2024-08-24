{ hostname, defaultUser, inputs, stateVersion, config, lib, pkgs, ... }: {
  # Import secrets module
  imports = [
    inputs.private.nixosModules.secrets
  ];

  # Enable custom modules
  modules = {
    wsl.enable = true;
    wsl.docker-desktop.enable = true;
    dynamic-fix.enable = true;
    neovim.enable = true;
    basic-tools.enable = true;
    zsh-setup.enable = true;
    terraform.enable = true;
    secrets.enable = true;
  };
}
