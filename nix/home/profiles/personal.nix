{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  omp = import ../../home/modules/oh-my-posh/segments.nix;
in
{
  options.dotfiles.profiles.personal.enable = lib.mkEnableOption "essential packages for personal environments";

  config = lib.mkIf config.dotfiles.profiles.personal.enable {
    dotfiles = {
      profiles = {
        desktop.enable = true;
        python.enable = true;
        terminal = {
          enable = true;
          blocks = [
            {
              alignment = "left";
              type = "prompt";
              segments = with omp.segments; [
                os
                session
                git
              ];
            }
            {
              alignment = "right";
              type = "prompt";
              segments = with omp.segments; [
                node
                python
              ];
            }
            {
              alignment = "left";
              type = "prompt";
              newline = true;
              segments = with omp.segments; [ path ];
            }
            omp.segments.status
          ];
        };
      };
      aws.enable = true;
      git = {
        enable = true;
        userName = "Ali Tayarani";
        userEmail = "619512+atayarani@users.noreply.github.com";
      };
      zsh.enable = true;
    };
  };
}
