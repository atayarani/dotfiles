{
  pkgs,
  config,
  lib,
  ...
}: with lib;
let
  cfg = config.dotfiles.chezmoi;
  homeDir = config.home.homeDirectory;
in
{
  # home.packages = with pkgs; [ chezmoi ];
  # home.homebrew.brews = [ " chezmoi"];

  options.dotfiles.chezmoi.enable = mkEnableOption "chezmoi";
  config = mkIf cfg.enable {
  home.activation.chezmoi = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # echo -e "\033[0;34mActivating chezmoi"
    # echo -e "\033[0;34m=================="
    /opt/homebrew/bin/chezmoi apply -S ${homeDir}/code/github.com/atayarani/dotfiles/chezmoi --verbose
    # echo -e "\033[0;34m=================="
  '';
  };
}
