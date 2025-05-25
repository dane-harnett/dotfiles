{
  config,
  lib,
  ...
}: let
  cfg = config.fx-cast-bridge;
in {
  options = {
    fx-cast-bridge = {
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
