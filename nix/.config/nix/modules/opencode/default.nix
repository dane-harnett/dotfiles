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
      casks = [
        "anomalyco/tap/opencode"
      ];
      taps = [
        "anomalyco/tap"
      ];
    };
  };
}
