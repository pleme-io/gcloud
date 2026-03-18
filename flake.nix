{
  description = "Google Cloud SDK — tracks latest release independent of nixpkgs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      mkGcloud = pkgs: pkgs.google-cloud-sdk.overrideAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      });
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        gcloud = mkGcloud pkgs;
      in {
        packages = {
          default = gcloud;
          google-cloud-sdk = gcloud;
        };

        apps.default = {
          type = "app";
          program = "${gcloud}/bin/gcloud";
        };

        devShells.default = pkgs.mkShellNoCC {
          packages = [ gcloud ];
          shellHook = ''
            echo "gcloud $(gcloud --version 2>&1 | head -1)"
          '';
        };
      }
    ) // {
      overlays.default = final: prev: {
        google-cloud-sdk = mkGcloud final;
      };
    };
}
