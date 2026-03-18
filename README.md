# gcloud

Nix flake providing Google Cloud SDK with tests disabled for fast builds.

Tracks `nixpkgs-unstable` which updates `google-cloud-sdk` frequently. To get the latest version, run `nix flake update`.

## Usage

```bash
# Run directly
nix run github:pleme-io/gcloud -- info

# Add to a flake
{
  inputs.gcloud.url = "github:pleme-io/gcloud";

  # In your config:
  home.packages = [ gcloud.packages.${system}.default ];

  # Or use the overlay:
  nixpkgs.overlays = [ gcloud.overlays.default ];
}
```

## Updating

```bash
nix flake update  # pulls latest nixpkgs-unstable
```

## License

[MIT](LICENSE)
