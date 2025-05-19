{ hostname, defaultUser, inputs, stateVersion, config, lib, pkgs, ... }: {
  # Import home manager and nixos-wsl
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
    inputs.private.nixosModules.secrets
    ../../modules/nixos
  ];

  # WSL settings
  wsl = {
    enable = true;
    defaultUser = defaultUser;
    docker-desktop.enable = true;
  };

  # Enable custom modules
  modules = {
    dynamic-fix.enable = true;
    secrets.enable = true;
  };

  # Set default shell
  # TODO: Experiment how much of this I can move to home-manager
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Manage everything else through home-manager
  # TODO: This should be standardized for evey host
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs stateVersion; };
    users.${defaultUser}.imports = [ ./home.nix ];
  };

  # Enable nerd fonts and set JetBrains Mono as default
  fonts = {
    packages = with pkgs; [
      nerdfonts
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };

  # Enable direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  # Set timezone
  # TODO: Make this an overridable default for all hosts
  time.timeZone = "Europe/Berlin";
}
