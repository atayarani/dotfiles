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

{ config, pkgs, vars, ... }:

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
    systemPackages = with pkgs; [         # System-Wide Packages
      # Terminal
      fzf
      git
      neovim
      oh-my-posh
      zsh
    ];
  };

  nix = {
    package = pkgs.nix;
    gc = {                                # Garbage Collection
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  homebrew = {                            # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
   #   cleanup = "zap";
    };
    brews = [
    ];
    casks = [
     "1password-beta"
    ];
  };

  home-manager.users.${user} = {
    home = {
      stateVersion = "22.05";
    };

    programs = {
      fzf = {
        enable = true;
      };
      oh-my-posh = {
        enable = true;
      };
      zsh = {
        enable = true;
      };
    };
  };
}

