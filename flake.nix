{
  description = "My (hopefully) awesome dotfiles (:";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-25.11";
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

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "24.05";

    forEachSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    pkgsFor = forEachSystem (system: import nixpkgs {inherit system;});

    mkSystem = {
      system,
      hostname,
      defaultUser,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostname defaultUser stateVersion;
        };

        modules = [
          self.nixosModules.default
          ./hosts/${hostname}/configuration.nix
        ];
      };
  in {
    nixosConfigurations.daedalus = mkSystem {
      system = "x86_64-linux";
      hostname = "daedalus";
      defaultUser = "rodney";
    };

    nixosConfigurations.apollo = mkSystem {
      system = "x86_64-linux";
      hostname = "apollo";
      defaultUser = "rodney";
    };

    nixosModules.default = {...}: {
      imports = [
        inputs.nixos-wsl.nixosModules.wsl
        inputs.nixvim.nixosModules.nixvim
        ./host-defaults.nix
      ];
    };

    devShells = forEachSystem (system: {
      default = pkgsFor.${system}.mkShell {
        shellHook = ''
          echo Hi there! 🚀
        '';
      };
    });

    formatter = forEachSystem (system: pkgsFor.${system}.alejandra);
  };
}
