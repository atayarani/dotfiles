{
  config,
  lib,
  pkgs,
  dotfiles,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin system;
  myPkgs = dotfiles.packages.${system};
in
{
  options.dotfiles.profiles.essential.enable = lib.mkEnableOption "essential packages for servers and desktops alike";

  config = lib.mkIf config.dotfiles.profiles.essential.enable {
    home.packages =
      with pkgs;
      [
        bat
        broot
        cmigemo
        fd
        fselect
        ghq
        gitstatus
        httpie
        jq
        lsof
        magic-wormhole
        neofetch
        nixpkgs-fmt
        nkf
        ranger
        tig
        tmux
        wget
        zsh-completions
        gitAndTools.git-absorb
        nodePackages.prettier
      ]
      ++ lib.optionals (!isDarwin) [
        dnsutils
        file
        libarchive
        git
        netcat
        whois
      ]
      ++ lib.optionals isDarwin [
        ssh-copy-id
        watch
      ];

    dotfiles = {
      # git.enableDelta = lib.mkDefault true;
      manpages.colorize = lib.mkDefault true;
    };
  };
}
