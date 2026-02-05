{ ... }: {
  # Enable custom modules
  rmkmodules = {
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
