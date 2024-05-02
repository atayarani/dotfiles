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
      eval "$(fnm env --use-on-cd)"
    '';

    initExtraFirst = ''
      if [ -f $HOME/.config/zsh/zshrc ]; then
        source $HOME/.config/zsh/zshrc
      fi
    '';

    initExtra=''
        export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
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
