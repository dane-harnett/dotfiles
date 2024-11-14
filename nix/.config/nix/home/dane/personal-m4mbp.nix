# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "dane";
  home.homeDirectory = "/Users/dane";
  home.stateVersion = "24.05";

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    #".zshrc".source = ../../../zsh/.zshrc;
    ".config/aerospace".source = ../../../../../aerospace/.config/aerospace;
    ".config/borders".source = ../../../../../borders/.config/borders;
    ".config/nvim".source = ../../../../../nvim/.config/nvim;
    ".config/nvm".source = ../../../../../nvm/.config/nvm;
    ".config/sketchybar".source = ../../../../../sketchybar/.config/sketchybar;
    # ".p10k.zsh".source = ../../../zsh/.p10k.zsh;
    ".wezterm.lua".source = ../../../../../wezterm/.wezterm.lua;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromTOML (builtins.unsafeDiscardStringContext (builtins.readFile ../../../../../oh-my-posh/.config/oh-my-posh/default.toml));
  };
  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ../../../../../zsh/.zshrc;
    antidote = {
      enable = true;
      plugins = [
        "jimhester/per-directory-history"
        "mattmc3/zephyr path:plugins/completion"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
        "chrisands/zsh-yarn-completions"
        "chitoku-k/fzf-zsh-completions"
      ];
    };
    autosuggestion.enable = true;
    defaultKeymap = "viins";
    historySubstringSearch = {
      enable = true;
    };
    shellAliases = {
      ll = "ls -lah";
      ls = "eza";
      cd = "z";
      zz = "z -";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
