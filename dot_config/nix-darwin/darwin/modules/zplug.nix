{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.zplug;
  plugins = import ./zplug-plugins/plugins.nix;
in {
  options.zplug = {
    enable = mkEnableOption "zplug";
    osUser = mkOption {type = types.str;};

    plugins = {
      fnm = mkEnableOption "fnm";
      # git = mkEnableOption "git";
      # pyenv = mkEnableOption "pyenv";
    };
  };

  config = {
    home-manager.users.${cfg.osUser}.programs.zsh.zplug = mkIf cfg.enable {
      enable = cfg.enable;
      plugins = [
        # (mkIf cfg.plugins.git plugins.git)
        (mkIf cfg.plugins.fnm plugins.fnm)
        # (mkIf cfg.plugins.pyenv plugins.pyenv)
      ];
    };
  };
}
