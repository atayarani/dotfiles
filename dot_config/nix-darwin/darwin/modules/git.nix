{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Enable Git Configuration
      '';
    };
    osUser = mkOption {
      type = types.str;
      description = mdDoc ''
        OS User
      '';
    };
    userName = mkOption {
      type = types.str;
      default = null;
      description = mdDoc ''
        Git User Name
      '';
    };
    userEmail = mkOption {
      type = types.str;
      default = null;
      description = mdDoc ''
        Git User Email
      '';
    };
  };

  config = mkIf config.git.enable {
    home-manager.users.${config.git.osUser} = {
      programs.git = {
        enable = config.git.enable;
        diff-so-fancy = {enable = true;};
        lfs = {enable = true;};
        userEmail = config.git.userEmail;
        userName = config.git.userName;
        ignores = [
        ];
        extraConfig = {
          pull = {rebase = true;};
          init = {defaultBranch = "main";};
          push = {default = "current";};
          fetch = {
            prune = true;
            pruneTags = true;
          };
          rebase = {autostash = true;};
          color = {ui = true;};
        };
        aliases = {track = "!f() { git branch --set-upstream-to=origin/\"$1\" \"$1\"; }; f";};
      };
    };
  };
}
