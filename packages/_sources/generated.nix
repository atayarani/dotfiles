# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  cloudfoundry-cli-6 = {
    pname = "cloudfoundry-cli-6";
    version = "v6.53.0";
    src = fetchFromGitHub ({
      owner = "cloudfoundry";
      repo = "cli";
      rev = "v6.53.0";
      fetchSubmodules = false;
      sha256 = "sha256-1IFufrKZvKlbgyoItOnapNCOTWqvV62BH+3q8d1oMtw=";
    });
  };
}