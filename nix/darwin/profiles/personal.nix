{ config, lib, ... }:

{
  options.dotfiles.profiles.personal.enable = lib.mkEnableOption "Apps for Personal";

  config = lib.mkIf config.dotfiles.profiles.personal.enable {
    # Manage Homebrew with nix-darwin. Mainly useful for managing casks and
    # App Store installations. Any formula or cask not specified in the config
    # would be automatically uninstalled by default.

    homebrew = {
      enable = lib.mkDefault true;
      global.brewfile = lib.mkDefault true;
      onActivation = {
        autoUpdate = lib.mkDefault true;
        upgrade = lib.mkDefault true;
        cleanup = lib.mkDefault "zap";
      };

      brews = [
      "chezmoi"
        # "aws-cdk"
        # "aws-sso-util"
        # "coreutils" # GNU coreutils (ls, cat, etc.)
        # "emacs"
        # "fontconfig" # Required for emacs and doesn't work through nix for some reason
        # "grep" # GNU grep
        # "python@3.10"
        # "shellcheck"
        # "tenv"
        # "tmuxinator"
        # "tpm"
        # "xdg-ninja"
        # "granted"
      ];
      casks = [
      "arc"
      "1password"
      "zed"
        # "font-jetbrains-mono-nerd-font"
        # "iterm2"
        # "tailscale"
        # "orbstack"
        # "raycast"
        # "1password-cli"
      ];
      masApps = {        Infuse = 1136220934;
      LanScan = 472226235;};
      taps = [];
    };
  };
}
