{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  users.users.ali = {
    name = "ali";
    home = "/Users/ali";
  };

    environment.systemPackages = with pkgs;
    [ vim
      alacritty
      neovim
      oh-my-posh
    ];
}
