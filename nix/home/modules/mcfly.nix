{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.mcfly;
in
{
  options.dotfiles.mcfly.enable = lib.mkEnableOption "mcfly";
  config = lib.mkIf cfg.enable {
    programs.mcfly = {
      enable = true;
      fuzzySearchFactor = 5;
    };
  };
}
