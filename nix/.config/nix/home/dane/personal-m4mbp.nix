# home.nix
# home-manager switch

{ config, ... }:

{
  home = {
    username = "dane";
    homeDirectory = "/Users/dane";
    stateVersion = "24.05";

    # Makes sense for user specific applications that shouldn't be available system-wide
    packages = [
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      ".codex/AGENTS.md".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/agent-instructions/global-agent-instructions.md";
      ".codex/AGENTS.md".force = true;
      ".claude/CLAUDE.md".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/agent-instructions/claude.md";
      ".claude/CLAUDE.md".force = true;
      ".gemini/GEMINI.md".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/agent-instructions/gemini.md";
      ".gemini/GEMINI.md".force = true;
      ".config/aerospace".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/aerospace/.config/aerospace";
      ".config/borders".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/borders/.config/borders";
      ".config/cmux".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/cmux/.config/cmux";
      ".config/ghostty".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/ghostty/.config/ghostty";
      ".config/leader-key".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/leader-key/.config/leader-key";
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/nvim/.config/nvim";
      ".tmux.conf".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/tmux/.tmux.conf";
      ".config/wezterm".source = ../../../../../wezterm/.config/wezterm;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };
  programs = {
    home-manager.enable = true;
    atuin.enable = true;
    fzf = {
      enable = true;
      historyWidget.command = "";
    };
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        alias = {
          co = "checkout";
          st = "status";
        };
        core.editor = "nvim";
        user = {
          email = "2585257+dane-harnett@users.noreply.github.com";
          name = "Dane Harnett";
        };
      };
      signing.format = "openpgp";
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."github.com" = {
        HostName = "ssh.github.com";
        Port = 443;
        User = "git";
        IdentityFile = "~/.ssh/github";
        IdentitiesOnly = true;
        UseKeychain = true;
        AddKeysToAgent = "yes";
      };
    };
    oh-my-posh = {
      enable = true;
      settings = builtins.fromTOML (
        builtins.unsafeDiscardStringContext (
          builtins.readFile ../../../../../oh-my-posh/.config/oh-my-posh/default.toml
        )
      );
    };
    zsh = {
      enable = true;
      envExtra = ''
        # Make node and npm available in non-interactive zsh shells.
        [[ $(command -v "fnm") ]] && eval "$(fnm env --shell zsh --use-on-cd --log-level=quiet)"
      '';
      initContent = builtins.readFile ../../../../../zsh/.zshrc;
      antidote = {
        enable = true;
        plugins = [
          "zdharma-continuum/fast-syntax-highlighting kind:defer"
        ];
      };
      autosuggestion.enable = true;
      defaultKeymap = "viins";
      shellAliases = {
        ll = "ls -lah";
        ls = "eza";
        cd = "z";
        zz = "z -";
      };
      completionInit = ''
        autoload -Uz compinit
        compinit -C
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
