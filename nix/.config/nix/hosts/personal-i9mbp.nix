{ pkgs, inputs, self, ...}: {
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain._HIHideMenuBar = true;

    dock.autohide = true;

    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.FXPreferredViewStyle = "clmv";

    spaces.spans-displays = true;
  };

  system.keyboard.enableKeyMapping = true;

  system.keyboard.remapCapsLockToEscape = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
  };

  home-manager.backupFileExtension = "backup";

  users.users.dane.home = "/Users/dane";
  # home.homeDirectory = "/Users/${userSettings.userName}";
  aerospace.enable = true;
  antidote.enable = true;
  arc-browser.enable = true;
  bitwarden.enable = true;
  borders.enable = true;
  discord.enable = true;
  eza.enable = true;
  fd.enable = true;
  fnm.enable = true;
  fzf.enable = true;
  gnu-sed.enable = true;
  neovim.enable = true;
  nix-tools.enable = true;
  oh-my-posh.enable = true;
  raycast.enable = true;
  ripgrep.enable = true;
  sketchybar.enable = true;
  slack.enable = true;
  util-linux.enable = true;
  vscode.enable = true;
  wezterm.enable = true;
  zoxide.enable = true;
}
