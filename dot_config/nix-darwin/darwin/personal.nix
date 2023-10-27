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

{ config, pkgs, vars, darwinVars, ... }:

let 
  user = "alitayarani";
in
{
  #imports = ( import ./modules );

  users.users.${user} = {            # MacOS User
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh;                     # Default Shell
  };
  
  environment = {
    shells = with pkgs; [ zsh ];          # Default Shell
    variables = {                         # Environment Variables
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages =  [];

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

  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  services = { 
    nix-daemon = { enable = true; }; 
    yabai = {
      enable = false;
      enableScriptingAddition = true;
    };
  };

  homebrew = {                            # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [
      "fnm"
    ];
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
    ];
    masApps = {
      Infuse = 1136220934;
      LanScan = 472226235;
    };
    taps = [
      "homebrew/cask-versions"
    ];
  };

  home-manager.users.${user} = {
    home = {
      sessionVariables = {
        EDITOR = "nvim";
        PATH = "/run/current-system/sw/bin/:$HOME/.config/zsh/scripts:/opt/homebrew/bin:$PATH";
      };
      stateVersion = "23.05";
      shellAliases = {
        xdg-ninja = "nix run github:b3nj5m1n/xdg-ninja";
      };
    };

    xdg = { enable = true; };

    programs = {
      alacritty = { enable = true; };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      gh = { enable = true; };
      git = { enable = true; };
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
      };
      go = { enable = true; };
      gpg = { enable = true; };
      jq = { enable = true; };
      oh-my-posh = { enable = true; };
      pandoc = { enable = true; };
      ssh = { enable = true; };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        initExtra = " eval \"$(fnm env --use-on-cd)\" ";

        dotDir = ".config/zsh";
        zplug = {
          enable = true;
          plugins = [
            { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
            { name = "plugins/fnm"; tags = [ from:oh-my-zsh ]; }
          ];
        };
      };
    };
  };
}

