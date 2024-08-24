{ stateVersion, inputs }: { config, pkgs, ... }: {
  home.stateVersion = stateVersion;

  imports = [
    (import ../../modules inputs)
  ];

  modules = {
    git.enable = true;
    nvim.enable = true;
  };
}
