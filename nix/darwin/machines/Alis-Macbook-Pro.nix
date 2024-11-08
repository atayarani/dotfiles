{ config, pkgs, ... }:

let
  username = config.dotfiles.flakeOptions.user.name;
in
{

  users.users.${username}.home = "/Users/${username}";

  # environment.systemPackages = with pkgs; [
  #   nixfmt-rfc-style
  #   nil
  #   fnm
  #   sops
  # ];

  dotfiles.profiles.personal.enable = true;

  home-manager.users.${username} = {
    dotfiles.profiles.personal.enable = true;
    home.stateVersion = "24.05";
  };

  system.stateVersion = 4;
}
