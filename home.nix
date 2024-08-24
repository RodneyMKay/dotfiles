{config, pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "RodneyMKay";
    userEmail = "36546810+RodneyMKay@users.noreply.github.com";
  };

  home.stateVersion = "24.05";

  imports = [
    ./modules/nvim
  ];

  modules = {
    nvim.enable = true;
  };
}
