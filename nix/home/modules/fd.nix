{ config, lib, ... }:
with lib;
let
  cfg = config.dotfiles.fd;
in
{
  options.dotfiles.fd.enable = mkEnableOption "fd";
  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
      hidden = true;
    };
  };
}
