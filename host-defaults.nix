{ hostname, username, stateVersion, config, lib, pkgs, inputs, ... }: {
  # Set the properties that we inherit from flake.nix
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # Always enable flakes, since we use it in this setup
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable regular garbage collection that cleans all packages
  # that are both old and unused
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
    dates = "weekly";
  };
}
