{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.navi;
in
{
  options.dotfiles.navi.enable = mkEnableOption "navi";
  config = mkIf cfg.enable { programs.navi.enable = true; };
}
