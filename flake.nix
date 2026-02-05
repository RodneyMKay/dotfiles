{
  description = "My (hopefully) awesome dotfiles (:";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-25.11";
    };

    private = {
      url = "github:input-output-hk/empty-flake?ref=2040a05b67bf9a669ce17eca56beb14b4206a99a";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim?ref=nixos-25.11";
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

    mkSystem = { system, inputs, hostname, defaultUser }: nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = {
        inherit inputs hostname defaultUser stateVersion;
      };
      
      modules = [
        inputs.nixvim.nixosModules.nixvim
        inputs.nixos-wsl.nixosModules.wsl
        ./host-defaults.nix
        ./hosts/${hostname}/configuration.nix
      ];
    };
  in {
    nixosConfigurations.daedalus = mkSystem {
      inherit inputs;
      system = "x86_64-linux";
      hostname = "daedalus";
      defaultUser = "rodney";
    };

    nixosConfigurations.apollo = mkSystem {
      inherit inputs;
      system = "x86_64-linux";
      hostname = "apollo";
      defaultUser = "rodney";
    };

    nixosModules.default = {...}: {
      imports = [
        inputs.nixvim.nixosModules.nixvim
        inputs.nixos-wsl.nixosModules.wsl
        ./host-defaults.nix
      ];
    };
  };
}
