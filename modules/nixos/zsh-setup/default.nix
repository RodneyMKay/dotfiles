{ lib, config, pkgs, ... }:
let
  cfg = config.rmkmodules.zsh-setup;
in {
  options.rmkmodules.zsh-setup = {
    enable = lib.mkEnableOption "Enable ZSH, fzf, bat, etc.";
  };

  config = lib.mkIf cfg.enable {
    # Include packages
    environment.systemPackages = with pkgs; [
      eza
      fzf
    ];

    # Set zsh as default shell
    users.defaultUserShell = pkgs.zsh;

    # Set up zsh
    environment.etc."zsh-custom/plugins" = {
      source = ./custom-plugins;
    };

    programs.zsh = {
      enable = true;

      shellAliases = {
        ls = "eza";
        ll = "eza -l";
        la = "eza -a";
        lt = "eza --tree";
        lla = "eza -la";
      };

      # Disable special history syntax for bang in strings
      interactiveShellInit = ''
        unsetopt histexpand
      '';

      ohMyZsh = {
        enable = true;

        custom = "/etc/zsh-custom";

        plugins = [
          # Builtin plugins
          "git"
          "rsync"
          "cp"
          "eza"
          "fzf"

          # Custom plugins
          "wslscripts"
          "projects"
          "tfscripts"
        ];
      };
    };

    # Enable new zsh prompt mechanism
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;

        format = "[\\[](bold bright-black)$username$hostname[\\]](bold bright-black) $directory$git_branch\${custom.git_dirty}$git_status[$all](248)";
        right_format = "$status";

        username = {
          show_always = true;
          style_user = "bold green";
          style_root = "bold red";
          format = "[$user]($style)";
        };

        hostname = {
          ssh_only = false;
          style = "bold prev_fg";
          format = "[@$hostname]($style)";
        };

        cmd_duration = {
          disabled = true;
        };

        directory = {
          style = "bold blue";
          truncation_length = 10;
        };

        git_branch = {
          style = "red";
          format = "[\\(](bold bright-black)[$branch]($style)[\\)](bold bright-black) ";
        };

        git_status = {
          style = "bold bright-purple";
          format = "([$ahead_behind]($style) )";
          up_to_date = "";
          ahead = "↑";
          behind = "↓";
          diverged = "↕";
        };

        character = {
          success_symbol = "[❯](bold cyan)";
          error_symbol = "[❯](bold cyan)";
        };

        status = {
          disabled = false;
          symbol = "⏎";
          style = "red";
          format = "[$symbol]($style)";
        };

        package = {
          disabled = true;
        };

        nix_shell = {
          format = "in [$symbol]($style)";
        };

        custom = {
          git_dirty = {
            when = ./starship-git-dirty.zsh;
            format = "[⚡](yellow) ";
          };
        };
      };
    };

    # Setup direnv (.envrc files)
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    # Setup bat (just enable it - cat should stay the same)
    programs.bat = {
      enable = true;
    };
  };
}
