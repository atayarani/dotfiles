{ config, lib, ... }:
with lib;
let
  cfg = config.dotfiles.bat;
in
{
  options.dotfiles.bat.enable = mkEnableOption "bat";
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config.theme = "Catppuccin Mocha";
    };
  };
}
