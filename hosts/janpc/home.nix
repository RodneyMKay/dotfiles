{ config, pkgs, stateVersion, inputs, ... }: {
  home.stateVersion = stateVersion;

  imports = [
    ../../modules
  ];

  modules = {
    git.enable = true;
    nvim.enable = true;
  };
}
