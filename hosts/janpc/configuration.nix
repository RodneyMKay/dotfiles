{ hostname, username, inputs, stateVersion, config, lib, pkgs, ... }: {
  # Import home manager and nixos-wsl
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
  ];

  # WSL settings
  wsl = {
    enable = true;
    defaultUser = username;
  };

  # Set timezone
  time.timeZone = "Europe/Berlin";

  # Unmanaged packages
  environment.systemPackages = [
    pkgs.zip
    pkgs.unzip
    pkgs.netcat-gnu
  ];

  # Enable podman
  # TODO: This should probably be in it's own module
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  # Set default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Manage everything else through home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs stateVersion; };
    users.${username}.imports = [ ./home.nix ];
  };
}
