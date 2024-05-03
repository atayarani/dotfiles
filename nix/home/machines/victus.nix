{ pkgs, ... }:

let
  omp = import ../modules/oh-my-posh/segments.nix;
  omp_theme = import ../modules/oh-my-posh/themes.nix;
in
{
  imports = [
    ../modules/zsh.nix
    ../modules/oh-my-posh.nix
    ../modules/git.nix
    ../modules/chezmoi.nix
    ../modules/ripgrep.nix
    ../modules/pandoc.nix
    ../modules/emacs.nix
  ];

  dotfiles.git = {
    enable = true;
    userName = "Ali Tayarani";
    userEmail = "619512+atayarani@users.noreply.github.com";
  };

  dotfiles.oh-my-posh = {
    enable = true;
    theme = omp_theme.mocha;
    blocks = [
      {
        alignment = "left";
        type = "prompt";
        segments = with omp.segments; [
          os
          session
          git
          aws
        ];
      }
      {
        alignment = "right";
        type = "prompt";
        segments = with omp.segments; [
          node
          python
        ];
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
}
