{
  config,
  lib,

  ...
}:
with lib;
let
  cfg = config.dotfiles.mcfly;
in
{
  options.dotfiles.mcfly.enable = mkEnableOption "mcfly";
  config = mkIf cfg.enable {
    programs.mcfly = {
      enable = true;
      fuzzySearchFactor = 5;
    };
  };
}
