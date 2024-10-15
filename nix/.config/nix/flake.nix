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

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.antidote
          pkgs.arc-browser
          pkgs.discord
          pkgs.eza
          pkgs.fd
          pkgs.fnm
          pkgs.fzf
          pkgs.neovim
          pkgs.oh-my-posh
          pkgs.raycast
          pkgs.ripgrep
          pkgs.slack
          # spotify times out when installing :(
          # pkgs.spotify
          pkgs.util-linux # TODO: define why I need/want this.
          pkgs.vscode
          pkgs.zoxide
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nixpkgs.config.allowUnfreePredicate =
        pkg: builtins.elem (pkgs.lib.getName pkg) [
          "arc-browser"
          "discord"
          "raycast"
          "slack"
          "spotify"
          "vscode"
        ];

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      programs.zsh.enableCompletion = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.defaults = {
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain._HIHideMenuBar = true;

        dock.autohide = true;
        dock.persistent-apps = [
          "/Applications/Nix Apps/Arc.app"
          "/Applications/Nix Apps/Slack.app"
          "/Applications/Nix Apps/Discord.app"
          "/Applications/Bitwarden.app"
          "/Applications/WezTerm.app"
          "/Applications/Nix Apps/Visual Studio Code.app"
        ];

        finder.AppleShowAllExtensions = true;
        finder.AppleShowAllFiles = true;
        finder.FXPreferredViewStyle = "clmv";

        spaces.spans-displays = true;
      };

      system.keyboard.enableKeyMapping = true;

      system.keyboard.remapCapsLockToEscape = true;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";

      homebrew = {
        enable = true;
        brews = [
          {
            name = "FelixKratz/formulae/borders";
            restart_service = true;
          }
          "gnu-sed"
          {
            name = "FelixKratz/formulae/sketchybar";
            restart_service = true;
          }
        ];
        casks = [
          "bitwarden"
          "font-hasklug-nerd-font"
          "nikitabobko/tap/aerospace"
          "wez/wezterm/wezterm"
        ];
        onActivation.cleanup = "zap";
        taps = [
          "FelixKratz/formulae"
          "nikitabobko/tap"
          "wez/wezterm"
        ];
      };

      users.users.dane.home = "/Users/dane";
      home-manager.backupFileExtension = "backup";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."i9mbp" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            user = "dane";
          };
        }
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dane = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."i9mbp".pkgs;
  };
}
