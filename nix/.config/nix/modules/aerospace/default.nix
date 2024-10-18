{
  config,
  lib,
  ...
}: let
  cfg = config.aerospace;
in {
  options = {
    aerospace = {
      enable = lib.mkEnableOption "Enable aerospace";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "nikitabobko/tap/aerospace"
      ];
      taps = [
        "nikitabobko/tap"
      ];
    };
  };
}
