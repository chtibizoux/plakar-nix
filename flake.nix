{
  description = "Nix flake for Plakar (backup solution)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        pname = "plakar";
        version = "1.0.2";
      in
      {
        packages.${pname} = pkgs.buildGoModule rec {
          inherit pname version;

          src = pkgs.fetchFromGitHub {
            owner = "PlakarKorp";
            repo = "plakar";
            tag = "v${version}";
            hash = "sha256-peyATyUJe6EFvQutlBLpLjyXputdoKPQmqW8pYeXiVI=";
          };

          vendorHash = "sha256-r8zE1mwoPOcsMeUsm1Rfq5XQ6Rze/gmcMwilzfM4xOk=";

          meta = with pkgs.lib; {
            homepage = "https://plakar.io";
            changelog = "https://github.com/PlakarKorp/plakar/releases/tag/v${version}";
            description = "Effortless, distributed backup solution";
            license = licenses.isc;
            maintainers = [ ];
            mainProgram = "plakar";
            platforms = platforms.unix;
          };
        };

        packages.default = self.packages.${system}.${pname};
      }
    );
}
