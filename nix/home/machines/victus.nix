{ pkgs, ... }:

let
  omp = import ../modules/oh-my-posh/segments.nix;
  omp_theme = import ../modules/oh-my-posh/themes.nix;
in
{
  imports = [
    ../modules/chezmoi.nix
    ../modules/ripgrep.nix
    ../modules/pandoc.nix
    ../modules/emacs.nix
  ];
  home.packages = with pkgs; [
    nixfmt-rfc-style
    nil
  ];

  dotfiles.profiles.personal.enable = true;
  home.stateVersion = "24.05";
}
