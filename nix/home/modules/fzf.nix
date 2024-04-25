{ config, lib, ... }:
with lib;
let
  cfg = config.dotfiles.fzf;
in
{
  options.dotfiles.fzf.enable = mkEnableOption "fzf";
  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      colors = {
        "bg+" = "#313244";
        "fg+" = "#cdd6f4";
        "hl+" = "#f38ba8";
        bg = "#1e1e2e";
        fg = "#cdd6f4";
        header = "#f38ba8";
        hl = "#f38ba8";
        info = "#cba6f7";
        marker = "#f5e0dc";
        pointer = "#f5e0dc";
        prompt = "#cba6f7";
        spinner = "#f5e0dc";
      };
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
      fileWidgetCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
      changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
    };
  };
}
