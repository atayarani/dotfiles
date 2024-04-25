{ config, lib, ... }:
with lib;
let
  cfg = config.dotfiles.aws;
in
{
  options.dotfiles.aws.enable = mkEnableOption "aws";
  config = mkIf cfg.enable { programs.awscli.enable = true; };
}
