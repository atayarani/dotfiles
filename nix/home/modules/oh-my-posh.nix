{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dotfiles.oh-my-posh;
in
{
  options.dotfiles.oh-my-posh = {
    enable = mkEnableOption "oh-my-posh";
    blocks = mkOption { description = mdDoc ''Prompt Segments to Include''; };
    theme = mkOption { description = mdDoc ''Color Theme''; };
  };

  config = mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      settings = {
        version = 2;
        console_title_template = "{{.Folder}}{{if .Root}} ::  {{.Shell}}";
        final_space = true;
        pwd = "osc99";
        shell_integration = true;
        blocks = lists.flatten cfg.blocks;
        palette = cfg.theme;
      };
    };
  };
}
