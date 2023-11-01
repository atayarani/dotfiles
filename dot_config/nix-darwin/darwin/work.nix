{
  config,
  pkgs,
  darwinVars,
  ...
}: let
  hostVars = {
    inherit (darwinVars) editor user;
  };
  omp = import ./shared/oh-my-posh.nix;
in {
  imports = import ./modules;

  services = {nix-daemon.enable = true;}; # Auto-Upgrade Daemon

  users.users.${hostVars.user} = {
    # MacOS User
    name = hostVars.user;
    home = "/Users/${hostVars.user}";
    shell = pkgs.zsh; # Default Shell
  };

  git = {
    enable = true;
    osUser = hostVars.user;
    userName = "ChronoSerrano";
    userEmail = "117208915+ChewAli@users.noreply.github.com";
  };

  oh-my-posh = {
    enable = true;
    osUser = hostVars.user;
    blocks = [
      {
        alignment = "left";
        type = "prompt";
        segments = with omp.segments; [os session git aws];
      }
      {
        alignment = "right";
        type = "prompt";
        segments = with omp.segments; [node python battery time];
      }
      {
        alignment = "left";
        type = "prompt";
        newline = true;
        segments = with omp.segments; [path];
      }
      omp.segments.status
    ];
  };

  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      # cleanup = "zap";
    };
    brews = [];
    casks = [
    ];
    masApps = {
    };
    taps = [
    ];
  };

  zplug = {
    enable = true;
    osUser = hostVars.user;
    plugins = {
      git = true;
      pyenv = true;
    };
  };

  home-manager.users.${hostVars.user} = {pkgs, ...}: {
    home = {
      packages = with pkgs; [];
      stateVersion = "23.05";
      sessionVariables = {
        EDITOR = hostVars.editor;
        PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin/:$HOME/.config/zsh/scripts:/opt/homebrew/bin:$PATH";
        GRANTED_ALIAS_CONFIGURED = "true";
      };
      # file.".config/zsh/scripts/aws_pip".source = ./scripts/aws_pip
    };
    xdg = {enable = true;};

    programs = {
      # oh-my-posh = {
      #   enable = true;
      #   settings = {
      #     version = 2;
      #     console_title_template = "{{.Folder}}{{if .Root}} ::  {{.Shell}}";
      #     final_space = true;
      #     pwd = "osc99";
      #     shell_integration = true;

      #   blocks = [
      #     {
      #       alignment = "left";
      #       type = "prompt";
      #       segments = with omp.segments; [os session git aws];
      #     }
      #     {
      #       alignment = "right";
      #       type = "prompt";
      #       segments = with omp.segments; [node python battery time];
      #     }
      #     {
      #       alignment = "left";
      #       type = "prompt";
      #       newline = true;
      #       segments = with omp.segments; [path];
      #     }
      #     omp.segments.status
      #   ];
      # };
      # };
      ssh = {enable = true;};
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        #     enableFzfCompletion = true;
        #     enableFzfHistory = true;
        #     enableSyntaxHighlighting = true;

        envExtra = ''
          alias assume="source assume"
        '';

        history = {
          expireDuplicatesFirst = true;
          extended = true;
          #        ignoreAllDups = true;
          ignoreSpace = true;
          save = 5000;
          size = 1000000000;
        };

        # zplug = {
        #   enable = true;
        #   plugins = [
        #     {
        #       name = "plugins/git";
        #       tags = [from:oh-my-zsh];
        #     }
        #     {name = "mattberther/zsh-pyenv";}
        #   ];
        # };
      };
    };
  };
}
