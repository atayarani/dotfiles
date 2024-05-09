{ config, lib, ... }:
with lib;
let
  cfg = config.dotfiles.direnv;
in
{
  options.dotfiles.direnv.enable = mkEnableOption "direnv";
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
