{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dotfiles.git;
  username = config.dotfiles.flakeOptions.user.name;
  delta_themes = import ./delta/themes.nix;
in
{
  options.dotfiles.git = {
    enable = lib.mkEnableOption "git";
    userName = lib.mkOption {
      type = lib.types.str;
      description = "The name to use for git commits";
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The email to use for git commits";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = cfg.enable;
      package = pkgs.git;

      userName = cfg.userName;
      userEmail = cfg.userEmail;

      delta = {
        enable = true;
        options = {
          features = "decorations";
          decorations = delta_themes.catppuccin-mocha;
          navigate = true;
          side-by-side = true;
          true-color = "always";
        };
      };
      lfs.enable = true;
      ignores = [ ];
      includes = [ ];
      extraConfig = {
        color.ui = true;
        core.hooksPath = "$HOME/.config/git/hooks";
        fetch.prune = true;
        fetch.pruneTags = true;
        init.defaultBranch = "main";
        pull.rebase = true;
        push.default = "current";
        rebase.autoSquash = true;
        rebase.autoStash = true;
        merge.conflictStyle = "diff3";
      };
      aliases = {
        track = "!f() { git branch --set-upstream-to=origin/\"$1\" \"$1\"; }; f";
      };
    };
  };
}
