{ config, pkgs, stateVersion, inputs, ... }: {
  home.stateVersion = stateVersion;

  home.sessionVariables = {
    # FIXME: This should also be in a module.
    #  See more details in configuration.nix.
    #  The reason this is needed is that
    #  cgroupsv2 is installed on the system,
    #  but not detected by podman.
    PODMAN_IGNORE_CGROUPSV1_WARNING = "1";
  };

  # Install unmanaged packages
  home.packages = with pkgs; [
    zip
    unzip
    wget
    htop
    netcat-gnu
    tmux
    jq
    dig
    elan
    podman-compose
    nodejs
    pnpm
    php83
    php83Extensions.mysqli
    php83Packages.composer
    temurin-bin
    sops
    scala_3
    sshfs
    fastfetch
    inetutils
  ];

  imports = [
    inputs.private.homeManagerModules.ssh
    ../../modules/home-manager
  ];

  modules = {
    git.enable = true;
    nvim.enable = true;
    zsh.enable = true;
    fzf.enable = true;
    ssh.enable = true;
  };
}
