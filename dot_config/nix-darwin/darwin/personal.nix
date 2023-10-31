#
#  Specific system configuration settings for MacBook
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix
#       ├─ personal.nix *
#       ├─ work.nix
#       └─ ./modules
#           └─ default.nix
#
{
  config,
  pkgs,
  legacy,
  lib,
  darwinVars,
  ...
}: let
  hostVars = {
    inherit (darwinVars) editor;
    user = "alitayarani";
  };
  omp = import ./shared/oh-my-posh.nix;
in {
  imports = import ./modules;

  git = {
    enable = true;
    osUser = hostVars.user;
    userName = "ChronoSerrano";
    userEmail = "619512+ChronoSerrano@users.noreply.github.com";
  };

  users.users.${hostVars.user} = {
    # MacOS User
    name = hostVars.user;
    home = "/Users/${hostVars.user}";
    shell = pkgs.zsh; # Default Shell
  };

  nixpkgs.config.allowUnfree = true; # Allow Proprietary Software.
  environment = {
    shells = with pkgs; [zsh]; # Default Shell
    variables = {
      # Environment Variables
      EDITOR = "${hostVars.editor}";
      VISUAL = "${hostVars.editor}";
    };
    systemPackages = [
      # System-Wide Packages
      # Terminal
      #fzf
      #git
      #neovim
      #oh-my-posh
      #vim
      #zsh
      pkgs.alejandra
      legacy.fnm
      legacy.chezmoi
    ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services = {nix-daemon = {enable = true;};};

  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [];
    casks = [
      "1password-beta"
      "sonos"
      "alfred"
      "obsidian"
      "tailscale"
      "flux"
      "setapp"
      "iterm2"
      "openaudible"
      "steam"
      "itch"
      "zoom"
      "zotero"
      "alacritty"
      "espanso"
      "macupdater"
      "vscodium"
    ];
    masApps = {
      Infuse = 1136220934;
      LanScan = 472226235;
    };
    taps = [
      "homebrew/cask-versions"
    ];
  };

  home-manager.users.${hostVars.user} = {
    home = {
      sessionVariables = {
        EDITOR = "nvim";
        PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin/:$HOME/.config/zsh/scripts:/opt/homebrew/bin:$PATH";
      };
      stateVersion = "23.05";
      shellAliases = {
        xdg-ninja = "nix run github:b3nj5m1n/xdg-ninja";
      };
    };

    xdg = {enable = true;};

    programs = {
      alacritty = {
        enable = true;
        settings = {};
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      gh = {enable = true;};
      # git = git // {
      #   userName = "ChronoSerrano";
      #   userEmail = "619512+ChronoSerrano@users.noreply.github.com";
      # };
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
      };
      go = {enable = true;};
      gpg = {enable = true;};
      jq = {enable = true;};
      oh-my-posh = {
        enable = true;
        settings = {
          blocks = [
            {
              alignment = "left";
              type = "prompt";
              segments = with omp.segments; [
                os
                session
                git
              ];
            }
          ];
        };
      };
      pandoc = {enable = true;};
      ssh = {enable = true;};
      tealdeer = {enable = true;};
      tmux = {
        enable = true;
        clock24 = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        #syntaxHighlighting = { enable = true; };
        #zsh-abbr = { enable = true; };

        initExtra = " eval \"$(fnm env --use-on-cd)\" ";

        dotDir = ".config/zsh";
        zplug = {
          enable = true;
          plugins = [
            {
              name = "plugins/git";
              tags = [from:oh-my-zsh];
            }
            {
              name = "plugins/fnm";
              tags = [from:oh-my-zsh];
            }
          ];
        };
      };
    };
  };
}
