{
  description = "My (hopefully) awesome dotfiles (:";

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

    nixvim = {
      url = "github:nix-community/nixvim?ref=nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: let 
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "24.05";

    mkSystem = { system, inputs, hostname, username }: nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = {
        inherit inputs hostname username stateVersion;
      };
      
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./host-defaults.nix
      ];
    };
  in {
    nixosConfigurations.janpc = mkSystem {
      inherit inputs;
      system = "x86_64-linux";
      hostname = "janpc";
      username = "jan";
    };
  };
}
