{
  pkgs,
  inputs,
  self,
  ...
}:
{
  system.primaryUser = "dane";

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain._HIHideMenuBar = false;

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
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  home-manager.backupFileExtension = "backup";

  users.users.dane.home = "/Users/dane";
  # home.homeDirectory = "/Users/${userSettings.userName}";
  aerospace.enable = true;
  antidote.enable = true;
  bitwarden.enable = true;
  borders.enable = true;
  carapace.enable = true;
  cargo.enable = true;
  discord.enable = true;
  eza.enable = true;
  fd.enable = true;
  fnm.enable = true;
  font-jetbrains-mono-nerd-font.enable = true;
  fx-cast-bridge.enable = true;
  fzf.enable = true;
  gnu-sed.enable = true;
  leader-key.enable = true;
  neovim.enable = true;
  nix-tools.enable = true;
  obs.enable = true;
  oh-my-posh.enable = true;
  raycast.enable = false;
  ripgrep.enable = true;
  slack.enable = true;
  stow.enable = true;
  there.enable = true;
  util-linux.enable = true;
  vlc.enable = true;
  vscode.enable = true;
  wezterm.enable = true;
  wget.enable = true;
  yt-dlp.enable = true;
  zoxide.enable = true;
}
