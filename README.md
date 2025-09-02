# plakar-nix

Nix flake to package the Plakar CLI from https://github.com/PlakarKorp/plakar using `buildGoModule`.

## Usage

- Build the package:

```bash
nix build .#plakar
```

- Run the CLI:

```bash
nix run .#plakar -- version
nix run .#plakar -- help
```

- Use the built result directly:

```bash
./result/bin/plakar version
```

## Development

- Enter a dev shell (if added later):

```bash
nix develop
```

- Update the packaged version:
  - Edit `flake.nix` to change `version` and the GitHub `tag`.
  - Update `src.hash` and `vendorHash`:

```bash
# after bumping version, you can let Nix suggest the correct hashes
nix build .#plakar  # will fail with a message containing the expected hash
```

## Notes

- Upstream has historically printed a mismatched version in `plakar version` for some tags; the build uses the tag specified in `flake.nix` regardless of that output.
- This flake sets `packages.default = plakar` so you can omit the attribute when there is no ambiguity.
