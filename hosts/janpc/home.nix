{ stateVersion }: { config, pkgs, ... }: {
  home.stateVersion = stateVersion;

  imports = [
    ../../modules
  ];

  modules = {
    nvim.enable = true;
    git.enable = true;
  };
}
