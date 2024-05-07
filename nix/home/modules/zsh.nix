{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.dotfiles.zsh;
in
{
  options.dotfiles.zsh = {
    enable = mkEnableOption "zsh";
    runtime_dir = mkOption {
      type = types.str;
      default = "/run/user/$(id -u)";
    };
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      zsh-abbr = {
        enable = true;
        abbreviations = { };
      };
      zplug = {
        enable = true;
        plugins = [
          {
            name = "plugins/aws";
            tags = [ "from:oh-my-zsh" ];
          }
          { name = "olets/zsh-abbr"; }
          {
            name = "plugins/git";
            tags = [ "from:oh-my-zsh" ];
          }
          { name = "unixorn/fzf-zsh-plugin"; }
        ];
        zplugHome = "/$HOME/.config/zplug";
      };

      envExtra = ''
        export PATH=$HOME/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin/:/usr/local/bin:$PATH
        eval "$(fnm env --use-on-cd)"
        export COLORTERM=truecolor
        export TERM=xterm-256color
      '';

      initExtraFirst = ''
        if [ -f $HOME/.config/zsh/zshrc ]; then
          source $HOME/.config/zsh/zshrc
        fi
        export PATH=$HOME/.nix-profile/bin:$PATH
        export XDG_CONFIG_HOME=$HOME/.config
        export XDG_DATA_HOME=$HOME/.local/share
        export XDG_CACHE_HOME=$HOME/.cache
        export XDG_RUNTIME_DIR=${cfg.runtime_dir}
        export XDG_STATE_HOME=$HOME/.local/state
      '';

      shellAliases = {
        cat = "bat";
      };

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        save = 5000;
        size = 1000000000;
        #path = "$XDG_DATA_HOME/zsh/zsh_history";
      };
    };
  };
}
