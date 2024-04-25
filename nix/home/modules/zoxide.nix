{
  config,
  lib,

  ...
}:
with lib;
let
  cfg = config.dotfiles.zoxide;
in
{
  options.dotfiles.zoxide.enable = mkEnableOption "zoxide";
  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
        "--hook pwd"
      ];
    };
  };
}
