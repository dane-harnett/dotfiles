{
  config,
  lib,
  ...
}: let
  cfg = config.fx-cast-bridge;
in {
  options = {
    sketchybar = {
      enable = lib.mkEnableOption "Enable fx-cast-bridge";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "fx-cast-bridge"
      ];
    };
  };
}
