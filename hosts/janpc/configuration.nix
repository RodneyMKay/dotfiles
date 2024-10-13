{ hostname, username, inputs, stateVersion, config, lib, pkgs, ... }: {
  # Import home manager and nixos-wsl
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

  # WSL settings
  wsl = {
    enable = true;
    defaultUser = username;
    docker-desktop.enable = true;
  };

  # Enable custom modules
  modules = {
    dynamic-fix.enable = true;
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
    users.${username}.imports = [ ./home.nix ];
  };

  # Set timezone
  # TODO: Make this an overridable default for all hosts
  time.timeZone = "Europe/Berlin";
}
