{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.eza;
in
{
  options.dotfiles.eza.enable = lib.mkEnableOption "eza";
  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = true;
      extraOptions = [
        "--all"
        "--long"
        "--header"
        "--dereference"
        "--time-style=long-iso"
        "--git"
        "--icons=always"
        "--color=always"
        "--group-directories-first"
        "--group"
      ];
    };
  };
}
