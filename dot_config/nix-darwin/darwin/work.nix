#
#  Specific system configuration settings for MacBook
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix
#       ├─ personal.nix *
#       ├─ work.nix
#       └─ ./modules
#           └─ default.nix
#

{ config, pkgs, vars, darwinVars, ... }:

let
in
{

    users.users.${vars.user} = {            # MacOS User
      name = vars.user;
      home = "/Users/${vars.user}";
      shell = pkgs.zsh;                     # Default Shell
    };

    environment = {
        shells = with pkgs; [ zsh ];          # Default Shell
        variables = {                         # Environment Variables
          EDITOR = "${vars.editor}";
          VISUAL = "${vars.editor}";
        };
        systemPackages =  [];

      };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
        "FiraCode"
        ];
      })
    ];
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

    nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

    services = { nix-daemon = { enable = true; }; }; # Enable Nix Daemon

  home-manager.users.${vars.user} = {
    home = {
       stateVersion = "23.05";
       sessionVariables = {
             EDITOR = "nvim";
             PATH = "/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/run/current-system/sw/bin/:$HOME/.config/zsh/scripts:/opt/homebrew/bin:$PATH";
             GRANTED_ALIAS_CONFIGURED = "true";
           };
        #  file.".config/zsh/scripts/aws_pip".source = ./scripts/aws_pip;
    };

    programs =
    { alacritty = { enable = true; }; };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        };
    programs.git = {
      enable = true;
      diff-so-fancy.enable = true;
      lfs.enable = true;
      userName = "ChronoSerrano";
      userEmail = "117208915+ChewAli@users.noreply.github.com";
      extraConfig = {
        pull = { rebase = true; };
        init = { defaultBranch = "main"; };
        push = { default = "current"; };
        fetch = {
          prune = true;
          pruneTags = true;
        };
        rebase = { autostash = true; };
        color = { ui = true; };
        core = { excludesFile = "/Users/ali/.config/git/gitignore"; };
      };
      aliases = {
        track = "!f() { git branch --set-upstream-to=origin/\"$1\" \"$1\"; }; f";
      };
    };

    programs.oh-my-posh = {
      enable = true;
      settings = {
        version = 2;
        console_title_template = "{{.Folder}}{{if .Root}} ::  {{.Shell}}";
        final_space = true;
        pwd = "osc99";
        shell_integration = true;

        blocks = [
          {
            alignment = "left";
            type = "prompt";
            segments = [{
              foreground = "cyan";
              background = "black";
              style = "powerline";
              type = "os";
              template = "{{ if .WSL }}WSL at {{ end }} {{.Icon}} ";
              properties = { macos = "MacOS"; };
            }
            {
              background = "#c386f1";
              foreground = "white";
              style = "powerline";
              powerline_symbol = "";
              type = "session";
              properties = { template = "{{ .UserName }}"; };
            }
            {
              background = "green";
              foreground = "white";
              style = "powerline";
              powerline_symbol = "";
              type = "git";
              properties = {
                fetch_status = true;
        template = ":: {{ .HEAD }}{{ .BranchStatus }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }} ";
              };
            }
            {
              type = "aws";
              style = "powerline";
              foreground = "white";
              background = "#FFA400";
              powerline_symbol = "";
              properties = { template = "  {{.Profile}}{{if .Region}}@{{.Region}}{{end}}"; };
            }
            ];
          }
          {
            alignment = "right";
            type = "prompt";
            segments = [{
              type = "node";
              foreground = "#6CA35E";
              style = "powerline";
              properties = { template = "|  {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} "; };
            }
            {
              type = "python";
              foreground = "#4574B6";
              style = "plain";
              properties = {
                display_mode = "context";
                fetch_virtual_env = true;
                template = "|  {{ .Venv }} ";
              };
            }
            {
              type = "battery";
              style = "powerline";
              invert_powerline = true;
              background_templates = [
                "{{if eq \"Charging\" .State.String}}#40c4ff{{end}}"
                "{{if eq \"Discharging\" .State.String}}#ff5722{{end}}"
                "{{if eq \"Full\" .State.String}}#4caf50{{end}}"
              ];
              properties = {
                charged_icon = " ";
                charging_icon = " ";
                discharging_icon = " ";
                template = "| {{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}";
              };
            }
            {
              type = "time";
              foreground = "lightGreen";
              style = "plain";
              properties = { template = "| {{ .CurrentDate | date .Format }} "; };
            }
            ];
          }
        {
          alignment = "left";
          type = "prompt";
          newline = true;
          segments = [{
            background = "#FF479C";
            foreground = "white";
            powerline_symbol = "";
            type = "path";
            style = "powerline";
            properties = {
              folder_separator_icon = "  ";
              home_icon = "~";
              style = "agnoster_full";
              template = "   {{ .Path }} ";
            };
          }];
        }
        {
          alignment = "left";
          type = "status";
          style = "diamond";
          foreground = "#ffffff";
          background = "#00897b";
          background_templates = [ "{{ if .Error }}#e91e63{{ end }}" ];
          trailing_diamond = "";
          template = "<#193549></>  ";
          properties = {
            always_enabled = true;
          };
        }
        ];
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
#     enableFzfCompletion = true;
      #     enableFzfHistory = true;
      #     enableSyntaxHighlighting = true;

      envExtra = ''
        alias assume="source assume"
        '';

      history = {
        expireDuplicatesFirst = true;
        extended = true;
#        ignoreAllDups = true;
        ignoreSpace = true;
        save = 5000;
        size = 1000000000;
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
          { name = "mattberther/zsh-pyenv"; }
        ];
      };
    };
  };
}
