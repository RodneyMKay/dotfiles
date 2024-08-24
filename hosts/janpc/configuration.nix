{ hostname, username, inputs, stateVersion, config, lib, pkgs, ... }: {
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
    extraSpecialArgs = { inherit inputs stateVersion; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username}.imports = [ ./home.nix ];
  };
}
