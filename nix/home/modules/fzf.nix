{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dotfiles.fzf;
in
{
  options.dotfiles.fzf.enable = lib.mkEnableOption "Enable fzf configuration";
  config = lib.mkIf cfg.enable {programs.fzf.enable = true;};
}
