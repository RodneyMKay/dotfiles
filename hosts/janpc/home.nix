{ config, pkgs, stateVersion, inputs, ... }: {
  home.stateVersion = stateVersion;

  imports = [
    ../../modules
  ];

  modules = {
    git.enable = true;
    nvim.enable = true;
    zsh.enable = true;
    fzf.enable = true;
  };
}
