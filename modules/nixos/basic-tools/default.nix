{ lib, config, pkgs, ... }:
let
  cfg = config.modules.basic-tools;
in {
  options.modules.basic-tools.enable = lib.mkEnableOption "Enable basic command line tools like zip, wget, dig, netcat, etc.";

  options.modules.basic-tools.git.username = lib.mkOption {
    description = "Username for Git";
    default = "RodneyMKay";
    type = lib.types.str;
  };

  options.modules.basic-tools.git.email = lib.mkOption {
    description = "Email address for Git";
    default = "36546810+RodneyMKay@users.noreply.github.com";
    type = lib.types.str;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zip
      unzip
      curl
      wget
      dig
      inetutils
      netcat-gnu
      jq
      fd
      ripgrep
      fastfetch
      btop
      openssl
      mitmproxy
    ];

    # Enable htop
    programs.htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };

    # Enable git
    programs.git = {
      enable = true;
      lfs.enable = true;

      config = {
        # Personal options
        user.name = cfg.git.username;
        user.email = cfg.git.email;

        # Important options
        init.defaultBranch = "main";
        credential.helper = "store";

        # Things that should be the default
        branch.sort = "-committerdate"; # Show newest branches first
        tag.sort = "version:refname"; # Sort tags by semver
        push.autoSetupRemote = "true"; # No set-upstream
        push.followTags = "true"; # Push tags by default
        help.autocorrect = "prompt"; # Prompt for typos
        commit.verbose = "true"; # Show diff when using "git commit" without "-m"

        # Make fetch a "mirror remote branches to local remote branches"
        fetch.prune = "true"; 
        fetch.pruneTags = "true";
        fetch.all = "true";

        # Prettier diff
        diff.colorMoved = "plain";
        diff.mnemonicPrefix = "true";
        diff.renames = "true";
        diff.algorithm = "histogram"; # Better diff algorithm

        # Better rebase 
        rebase.autoSquash = "true"; # Squash things committed with "--squash"
        rebase.autoStash = "true"; # Stash uncommitted changes before rebase
        rebase.updateRefs = "true"; # Update dependent branches automatically

        alias = {
          stage = "add";
          unstage = "restore --staged";

          track = "add -N";
          untrack = "rm --cached -r";

          amend = "commit -a --amend --no-edit";
          l = "log --graph --oneline --decorate";
          s = "status";
        };
      };
    };

    # Enable tmux
    programs.tmux.enable = true;
  };
}

