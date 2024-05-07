{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.zoxide;
in
{
  options.dotfiles.zoxide.enable = lib.mkEnableOption "zoxide";
  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
        "--hook pwd"
      ];
    };
  };
}
