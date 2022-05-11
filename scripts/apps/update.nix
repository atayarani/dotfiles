{ lib
, git
, nvfetcher
, writers

# FIXME: nixpkgs.nvfetcher has a missing dependency on nix-prefetch
, nix-prefetch
}:

writers.writeBash "update.sh" ''
set -euxo pipefail

export PATH="${lib.makeBinPath [ git nvfetcher nix-prefetch ]}''${PATH:+:$PATH}"

if ! [[ -f flake.nix && -d packages ]] ||
  [[ "$(git rev-parse --is-inside-work-tree)" != "true" ]]; then
  printf '[ERROR] This script appears to be run from the wrong directory. ' >&2
  printf 'Re-run this script from the root of the dotfiles repository.\n' >&2
fi

nix flake update
git submodule update --init --remote

pushd packages
nvfetcher
popd
''