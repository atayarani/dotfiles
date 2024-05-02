{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dotfiles.alacritty;
in
{
  options.dotfiles.alacritty.enable = lib.mkEnableOption "Enable alacritty configuration";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
        enable = true;
        settings = {
        font = {
            normal.family = "JetBrainsMono Nerd Font Mono";
            size = 13;
            offset.y = 2;
        };
        import = [ "$HOME/.config/alacritty/themes/catppuccino-mocha.toml" ];
        };
    };
  };
}
