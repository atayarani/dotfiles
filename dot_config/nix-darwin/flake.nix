#
#  flake.nix *
#   ├─ ./darwin
#   │   └─ default.nix
#   ├─ ./hosts
#   │   └─ default.nix
#
{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05"; # Stable Nix Packages (Default)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    home-manager = {
      # User Environment Manager
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      # MacOS Package Management
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    darwin,
  }:
  # Function telling flake which inputs to use
  let
    vars = {
      # Variables Used In Flake
      user = "ali";
      editor = "nvim";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Alis-MacBook-Pro-2

    nix.settings.experimental-features = "nix-command flakes";
    nix.settings.allowed-users = ["root" "alitayarani"];
    nix.settings.trusted-users = ["root" "alitayarani"];

    darwinConfigurations = (
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-unstable home-manager darwin vars;
      }
    );

    # Expose the package set, including overlays, for convenience.
    #darwinPackages = self.darwinConfigurations."Alis-MacBook-Pro-2".pkgs;
  };
}
