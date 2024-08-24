{config, pkgs, ...}: {
  home.stateVersion = "24.05";

  imports = [
    ./modules
  ];

  modules = {
    nvim.enable = true;
    git.enable = true;
  };
}
