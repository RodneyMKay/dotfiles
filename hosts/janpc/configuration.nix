{ hostname, username, stateVersion, config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
  ];

  wsl = {
    enable = true;
    defaultUser = username;
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = [
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ./home.nix {
      inherit stateVersion;
    };
  };
}
