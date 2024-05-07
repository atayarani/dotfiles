{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.bat;
in
{
  options.dotfiles.bat.enable = lib.mkEnableOption "bat";
  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
      };
    };
  };
}
