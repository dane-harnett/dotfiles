{
  description = "Dane Harnett Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    brew-src = {
      url = "github:Homebrew/brew/2eaef66d2d3d45b15c0d1fd703134f9dadb5c54e";
      flake = false;
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.brew-src.follows = "brew-src";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      brew-src,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          nixpkgs.config.allowUnfree = true;

          system.stateVersion = 5;
        };
      mkDarwinConfig =
        host: system: username:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
          madeConfig = {
            nixpkgs.hostPlatform = "${system}";
          };
          moduleFiles = builtins.attrNames (builtins.readDir ./modules);
          modules = map (name: ./modules + "/${name}") moduleFiles;
        in
        nix-darwin.lib.darwinSystem {
          modules = [
            madeConfig
            configuration

            ./hosts/${host}.nix

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = "${username}";
              };
            }

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home/${username}/${host}.nix;
            }
          ]
          ++ modules;
        };
    in
    {
      darwinConfigurations = {
        "personal-m4mbp" = mkDarwinConfig "personal-m4mbp" "aarch64-darwin" "dane";
      };
    };
}
