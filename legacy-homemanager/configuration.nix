{ hostname, defaultUser, inputs, stateVersion, config, lib, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs stateVersion; };
    users.${defaultUser}.imports = [ ./home.nix ];
  };
}
