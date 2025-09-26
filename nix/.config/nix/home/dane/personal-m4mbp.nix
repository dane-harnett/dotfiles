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
    ".config/aerospace".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/aerospace/.config/aerospace";
    ".config/borders".source = ../../../../../borders/.config/borders;
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/projects/personal/dotfiles/nvim/.config/nvim";
    ".config/nvm".source = ../../../../../nvm/.config/nvm;
    ".config/wezterm".source = ../../../../../wezterm/.config/wezterm;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Dane Harnett";
    userEmail = "2585257+dane-harnett@users.noreply.github.com";
    aliases = {
      co = "checkout";
      st = "status";
    };
  };
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromTOML (
      builtins.unsafeDiscardStringContext (
        builtins.readFile ../../../../../oh-my-posh/.config/oh-my-posh/default.toml
      )
    );
  };
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ../../../../../zsh/.zshrc;
    antidote = {
      enable = true;
      plugins = [
        "jimhester/per-directory-history"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
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
