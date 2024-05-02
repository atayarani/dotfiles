{ config, pkgs, ... }:

let
  username = config.dotfiles.flakeOptions.user.name;
  omp = import ../../home/modules/oh-my-posh/segments.nix;
  omp_theme = import ../../home/modules/oh-my-posh/themes.nix;
in {

  users.users.${username}.home = "/Users/${username}";

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
    fnm
    fzf
  ];

  dotfiles.profiles.work.enable = true;

  home-manager.users.${username} = {
    dotfiles.alacritty.enable = true;
    dotfiles.fzf.enable = true;

    dotfiles.git = {
      enable = true;
      userName = "Ali Tayarani";
      userEmail = "117208915+ChewAli@users.noreply.github.com";
    };

    dotfiles.oh-my-posh = {
      enable = true;
      theme = omp_theme.mocha;
      blocks = [
        {
          alignment = "left";
          type = "prompt";
          segments = with omp.segments; [ os session git aws ];
        }
        {
          alignment = "right";
          type = "prompt";
          segments = with omp.segments; [ node python ];
        }
        {
          alignment = "left";
          type = "prompt";
          newline = true;
          segments = with omp.segments; [ path ];
        }
        omp.segments.status
      ];
    };
    home.stateVersion = "23.11";
  };

  system.stateVersion = 4;

}
