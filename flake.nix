{
  description = "My awesome dotfiles (:";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: let 
    mkHost = { system, hostname, username, inputs }: inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = {
        inherit inputs hostname username;
      };
      
      modules = [
        inputs.nixos-wsl.nixosModules.wsl
        ./hosts/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix;
        }
      ];
    };
  in {
    nixosConfigurations.janpc = mkHost {
      inherit inputs;
      system = "x86_64-linux";
      hostname = "janpc";
      username = "jan";
    };
  };
}
