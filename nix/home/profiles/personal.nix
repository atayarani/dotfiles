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
  options.dotfiles.profiles.personal.enable = lib.mkEnableOption "essential packages for personal environments";

  config = lib.mkIf config.dotfiles.profiles.personal.enable {
    dotfiles = {
      profiles = {};
      chezmoi.enable = true;
    };
  };
}
