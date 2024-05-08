{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.aws;
in
{
  options.dotfiles.aws.enable = lib.mkEnableOption "aws";
  config = lib.mkIf cfg.enable {
    programs.awscli.enable = true;
    # programs.granted.enable = true;
  };
}
