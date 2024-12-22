{
  config,
  lib,
  ...
}: let
  cfg = config.obs;
in {
  options = {
    obs = {
      enable = lib.mkEnableOption "Enable obs";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "obs"
      ];
    };
    system.defaults = {
      dock.persistent-apps = [
        "/Applications/OBS.app"
      ];
    };
  };
}
