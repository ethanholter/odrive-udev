{
  description = "ODrive udev rules";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          odrive-udev-rules = pkgs.stdenvNoCC.mkDerivation {
            pname = "odrive-udev";
            version = "unstable-2026-04-22";

            src = pkgs.fetchurl {
              url = "https://cdn.odriverobotics.com/files/odrive-udev-rules.rules";
              hash = "sha256-tXRIbg/N8T8vqnFl9WNNRmNTJ0VHq006NrdfZ8cSTTw=";
            };

            dontUnpack = true;

            installPhase = ''
              install -Dm644 $src $out/lib/udev/rules.d/91-odrive.rules
            '';

            meta = with pkgs.lib; {
              description = "udev rules for ODrive motor controllers";
              homepage = "https://odriverobotics.com";
              platforms = platforms.linux;
            };
          };

          default = self.packages.${system}.odrive-udev-rules;
        });

      nixosModules.default = { pkgs, ... }: {
        services.udev.packages = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.odrive-udev-rules
        ];
      };
    };
}
