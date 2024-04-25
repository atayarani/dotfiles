{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    zplug.enable = true;
    # zsh-abbr.enable = true;
    zplug.plugins = [
        {name = "plugins/aws";tags = [from:oh-my-zsh];}
        {name = "olets/zsh-abbr";}
        {name = "plugins/git";tags = [from:oh-my-zsh];}
        {name = "plugins/aws";tags = [from:oh-my-zsh];}
    ];

    envExtra = ''
      export PATH=$HOME/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin/:/usr/local/bin:$PATH
    '';

    initExtraFirst = ''
      if [ -f $HOME/.config/zsh/zshrc ]; then
        source $HOME/.config/zsh/zshrc
      fi
    '';

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
}
