{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  options.dotfiles.profiles.python.enable = lib.mkEnableOption "essential packages for python environments";

  config = lib.mkIf config.dotfiles.profiles.python.enable {
    programs.poetry = {
      enable = true;
      settings = {
        virtualenvs.inProject = true;
      };
    };
  };
}
