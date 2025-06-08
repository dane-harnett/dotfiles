{
  config,
  lib,
  ...
}: let
  cfg = config.wezterm;
in {
  options = {
    wezterm = {
      enable = lib.mkEnableOption "Enable wezterm";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "wez/wezterm/wezterm"
      ];
      taps = [
        "wez/wezterm"
      ];
    };
  };
}
