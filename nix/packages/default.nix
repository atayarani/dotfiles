{
  lib,
  inputs,
  config,
  ...
}:

{
  perSystem =
    { pkgs, nixos, ... }:
    let
      inherit (pkgs.stdenv) isDarwin isLinux;
      nix = pkgs.nixVersions.${config.dotfiles.nix.package};
    in
    {
      packages = rec { } // lib.optionalAttrs isLinux { } // lib.optionalAttrs isDarwin { }; # // pkgs.callPackages ./skk-jisyo.nix { };
    };
}
