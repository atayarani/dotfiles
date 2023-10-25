{
  description = "Ali's work darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations."Alis-MacBook-Pro-2" = nix-darwin.lib.darwinSystem {
      modules = [ ./configuration.nix ./darwin-profiles/work.nix ];
    };
  };
}
