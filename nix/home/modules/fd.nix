{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.fd;
in
{
  options.dotfiles.fd.enable = lib.mkEnableOption "fd";
  config = lib.mkIf cfg.enable {
    programs.fd = {
      enable = true;
      hidden = true;
    };
  };
}
