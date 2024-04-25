{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.dotfiles.oh-my-posh;
  username = config.dotfiles.flakeOptions.user.name;
in
{
  options.dotfiles.oh-my-posh = {
    enable = mkEnableOption "oh-my-posh";
    # osUser = mkOption {type = types.str;};
    blocks = mkOption {description = mdDoc ''Prompt Segments to Include'';}; # type = types.inferred;
    theme = mkOption {description = mdDoc ''Color Theme'';}; # type = types.inferred;
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
        blocks = cfg.blocks;
        palette = cfg.theme;
      };
    };
  };
  # config = mkIf cfg.enable {
  #   home.users.${cfg.osUser}.programs.oh-my-posh = {
  #     enable = true;
  #     settings = {
  #       version = 2;
  #       console_title_template = "{{.Folder}}{{if .Root}} ::  {{.Shell}}";
  #       final_space = true;
  #       pwd = "osc99";
  #       shell_integration = true;

  #       blocks = cfg.blocks;
  #       palette = cfg.theme;
  #     };
  #   };
  # };
}
