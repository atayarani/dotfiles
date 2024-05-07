{ config, pkgs, ... }:

let
  username = config.dotfiles.flakeOptions.user.name;
in
{

  users.users.${username}.home = "/Users/${username}";

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
    fnm
  ];

  dotfiles.profiles.work.enable = true;

  home-manager.users.${username} = {
    dotfiles.profiles.work.enable = true;
    home.stateVersion = "23.11";
  };

  system.stateVersion = 4;
}
