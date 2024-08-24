{ hostname, stateVersion, config, lib, pkgs, inputs, ... }: {
  imports = [
    ./modules/nixos
  ];

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

  # Set timezone
  time.timeZone = "Europe/Berlin";

  # Set environment variables important when working with a proxy
  environment.variables = {
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    REQUESTS_CA_BUNDLE = "/etc/static/ssl/certs/ca-bundle.crt";
  };
}
