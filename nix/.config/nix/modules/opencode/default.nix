{
  config,
  lib,
  ...
}:
let
  cfg = config.opencode;
in
{
  options = {
    opencode = {
      enable = lib.mkEnableOption "Enable opencode";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "anomalyco/tap/opencode"
      ];
      taps = [
        "anomalyco/tap"
      ];
    };
  };
}
