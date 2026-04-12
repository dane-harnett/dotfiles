{
  config,
  lib,
  ...
}:
let
  cfg = config.wezterm;
in
{
  options = {
    wezterm = {
      enable = lib.mkEnableOption "Enable wezterm";
      nightly = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use nightly build of wezterm";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        (if cfg.nightly then "wez/wezterm/wezterm@nightly" else "wez/wezterm/wezterm")
      ];
      taps = [
        "wez/wezterm"
      ];
    };
  };
}
