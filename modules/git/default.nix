{ pkgs, ... }: {
  home.file.".config/nvim/init.lua".source = ./init.lua;

  programs.git = {
    enable = true;
  };
}
