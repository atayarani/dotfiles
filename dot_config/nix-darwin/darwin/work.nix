{
  config,
  pkgs,
  darwinVars,
  legacy,
  ...
}: let
  hostVars = {
    inherit (darwinVars) editor user;
  };
  omp = import ./shared/oh-my-posh.nix;
in {
  imports = import ./modules;

  services = {nix-daemon.enable = true;}; # Auto-Upgrade Daemon

  environment = {
    shells = with pkgs; [zsh]; # Default Shell
    variables = {
      # Environment Variables
      EDITOR = "${hostVars.editor}";
      VISUAL = "${hostVars.editor}";
    };
    systemPackages = [
      # System-Wide Packages
      pkgs.alejandra
      legacy.fnm
    ];
  };

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

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
      file.".config/zsh/scripts/aws_pip".source = ../scripts/aws_pip;
    };
    xdg = {enable = true;};

    programs = {
      ssh = {enable = true;};
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        #        vimDiffAlias = true;
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
          source ~/.config/zsh/scripts/aws_pip
        '';
        initExtra = " eval \"$(fnm env --use-on-cd)\" ";


        history = {
          expireDuplicatesFirst = true;
          extended = true;
          #        ignoreAllDups = true;
          ignoreSpace = true;
          save = 5000;
          size = 1000000000;
        };
      };
    };
  };
}
