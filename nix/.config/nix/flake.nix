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
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      ...
    }:
    let
      darwinSystem = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${darwinSystem};
      mkSourceCheck =
        {
          name,
          nativeBuildInputs,
          command,
        }:
        pkgs.runCommand name
          {
            inherit nativeBuildInputs;
            src = ./.;
          }
          ''
            cp -r "$src" source
            chmod -R u+w source
            cd source
            ${command}
            touch "$out"
          '';

      configuration = _: {
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        nix = {
          # Necessary for using flakes on this system.
          settings.experimental-features = "nix-command flakes";

          gc = {
            automatic = true;
            options = "--delete-older-than 30d";
          };
          optimise.automatic = true;
        };

        nixpkgs.config.allowUnfree = true;

        system.stateVersion = 5;
      };
      mkDarwinConfig =
        host: system: username:
        let
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
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import ./home/${username}/${host}.nix;
              };
            }
          ]
          ++ modules;
        };
    in
    {
      darwinConfigurations = {
        "personal-m4mbp" = mkDarwinConfig "personal-m4mbp" darwinSystem "dane";
      };

      formatter.${darwinSystem} = pkgs.nixfmt-tree;

      checks.${darwinSystem} = {
        system = self.darwinConfigurations.personal-m4mbp.system;

        homebrew-path =
          let
            darwinConfig = self.darwinConfigurations.personal-m4mbp.config;
            homebrewPrefix = darwinConfig.homebrew.prefix;
            systemPath = darwinConfig.environment.systemPath;
          in
          assert pkgs.lib.hasInfix "${homebrewPrefix}/bin" systemPath;
          assert pkgs.lib.hasInfix "${homebrewPrefix}/sbin" systemPath;
          pkgs.runCommand "check-homebrew-path" { } ''
            touch "$out"
          '';

        formatting = mkSourceCheck {
          name = "check-nix-formatting";
          nativeBuildInputs = [ pkgs.nixfmt-tree ];
          command = "treefmt --ci --tree-root . --walk filesystem";
        };

        statix = mkSourceCheck {
          name = "check-statix";
          nativeBuildInputs = [ pkgs.statix ];
          command = "statix check .";
        };

        deadnix = mkSourceCheck {
          name = "check-deadnix";
          nativeBuildInputs = [ pkgs.deadnix ];
          command = "deadnix --fail .";
        };
      };
    };
}
