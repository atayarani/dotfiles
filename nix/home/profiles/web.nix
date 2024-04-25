{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  options.dotfiles.profiles.web.enable = lib.mkEnableOption "nice defaults for web browsers";

  config = lib.mkIf config.dotfiles.profiles.web.enable {
    targets.darwin = lib.mkIf isDarwin {
      defaults."com.apple.Safari" = {
        AutoOpenSafeDownloads = lib.mkDefault false;
        AutoFillPasswords = lib.mkDefault false;
        AutoFillCreditCardData = lib.mkDefault false;
        IncludeDevelopMenu = lib.mkDefault true;
        ShowOverlayStatusBar = lib.mkDefault true;
      };

      search = lib.mkDefault "DuckDuckGo";
    };
  };
}
