{ config, lib, ... }:

{
  options.dotfiles.profiles.work.enable = lib.mkEnableOption "Apps for Work";

  config = lib.mkIf config.dotfiles.profiles.work.enable {
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
        "aws-cdk"
        "aws-sso-util"
        "coreutils" # GNU coreutils (ls, cat, etc.)
        "emacs"
        "fontconfig" # Required for emacs and doesn't work through nix for some reason
        "grep" # GNU grep
        "python@3.10"
        "shellcheck"
        "tenv"
        "tmuxinator"
        "tpm"
        "xdg-ninja"
        "granted"
      ];
      casks = [
        "font-jetbrains-mono-nerd-font"
        "iterm2"
        "tailscale"
        "orbstack"
        "raycast"
        "1password-cli"
      ];
      masApps = { };
      taps = [
        "homebrew/cask-fonts"
        "common-fate/granted"
      ];
    };
  };
}
