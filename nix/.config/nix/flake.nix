{
  description = "Dane Harnett Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix-darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # nix-homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    home-manager
  }:
  let
    configuration = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = 5;
    };
    mkDarwinConfig = host: system: username: let
      pkgs = import inputs.nixpkgs {inherit system;};
      madeConfig = {
        nixpkgs.hostPlatform = "${system}";
      };
    in
      nix-darwin.lib.darwinSystem {
        modules = [
          madeConfig
          configuration

          ./hosts/${host}.nix

          # ./hosts/shared.nix

          ./modules/aerospace
          ./modules/antidote
          ./modules/arc-browser
          ./modules/bitwarden
          ./modules/borders
          ./modules/discord
          ./modules/eza
          ./modules/fd
          ./modules/fnm
          ./modules/fzf
          ./modules/gnu-sed
          ./modules/neovim
          ./modules/nix-tools
          ./modules/oh-my-posh
          ./modules/raycast
          ./modules/ripgrep
          ./modules/sketchybar
          ./modules/slack
          ./modules/util-linux
          ./modules/vscode
          ./modules/wezterm
          ./modules/zoxide

          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              user = "${username}";
            };
          }

          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/${username}/${host}.nix;
          }
        ];
      };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple

    darwinConfigurations = {
      "personal-i9mbp" = mkDarwinConfig "personal-i9mbp" "x86_64-darwin" "dane";
      # "work-m1mbp" = mkDarwinConfig ./hosts/personal-m1mbp.nix "aarch64-darwin" "dharnett";
    };

    # personal intel i9 macbook pro
    # darwinConfigurations."i9mbp" = nix-darwin.lib.darwinSystem {
    #   modules = [
    #     configuration

    #   ];
    # };

    # work M1 macbook pro
    # darwinConfigurations."work-m1mbp" = nix-darwin.lib.darwinSystem {
    #   modules = [
    #     configuration
    #     nix-homebrew.darwinModules.nix-homebrew {
    #       nix-homebrew = {
    #         enable = true;
    #         user = "dharnett";
    #       };
    #     }
    #     home-manager.darwinModules.home-manager {
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;
    #       home-manager.users.dharnett = import ./home.nix;
    #     }
    #   ];
    # };

    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."work-m1mbp".pkgs;
  };
}
