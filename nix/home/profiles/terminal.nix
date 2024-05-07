{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  cfg = config.dotfiles.profiles.terminal;

  omp_theme = import ../../home/modules/oh-my-posh/themes.nix;
in
{
  options.dotfiles.profiles.terminal = {
    enable = lib.mkEnableOption "essential packages for terminal use";
    blocks = lib.mkOption {
      # type = lib.types.listOf Any;
      description = ''
        List of segments to include in the terminal profile.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    dotfiles.alacritty.enable = true;
    dotfiles.fzf.enable = true;
    dotfiles.eza.enable = true;
    dotfiles.fd.enable = true;
    dotfiles.bat.enable = true;
    dotfiles.zoxide.enable = true;
    dotfiles.mcfly.enable = true;
    dotfiles.oh-my-posh = {
      enable = true;
      theme = omp_theme.mocha;
      blocks = cfg.blocks;
    };
  };
}
