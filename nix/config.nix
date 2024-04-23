{ inputs }@localFlake:
{ lib, config, ... }@flake:

let
  cfg = flake.config.dotfiles;
  nixosRelease = localFlake.inputs.nixos.lib.trivial.release;
in
{
  options.dotfiles = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "The default username to use throughout this flake.";
        default = "ali";
      };

      fullName = lib.mkOption {
        type = lib.types.str;
        description = "The default full name to use throughout this flake.";
        default = cfg.user.name;
      };

      email = lib.mkOption {
        type = lib.types.str;
        description = "The default email to use throughout this flake.";
        default = "git@${cfg.user.name}.org";
      };

      pgpKey = lib.mkOption {
        type = lib.types.str;
        description = "The default PGP key to use throughout this flake.";
        default = "67654DA01D56BC17C7D1B4DDF90924651F6C2BB9";
      };
    };

    nix.package = lib.mkOption {
      type = lib.types.str;
      description = "The Nix package to use, specified by attribute name.";
      default = "nix_2_18";
    };

    home.modules = lib.mkOption {
      type = with lib.types; listOf deferredModule;
      default = [ ];
      description = ''
        Default list of modules to include when generating Home Manager
        configuration with `lib.mkHome` and `lib.importHome`.
      '';
    };

    nixos.modules = lib.mkOption {
      type = with lib.types; listOf deferredModule;
      default = [ ];
      description = ''
        Default list of modules to include when generating NixOS configuration
        with `lib.mkNixOS` and `lib.importNixOS`.
      '';
    };

    darwin.modules = lib.mkOption {
      type = with lib.types; listOf deferredModule;
      default = [ ];
      description = ''
        Default list of modules to include when generating nix-darwin
        configuration with `lib.mkDarwin` and `lib.importDarwin`.
      '';
    };
  };
}
