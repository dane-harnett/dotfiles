{
  config,
  lib,
  ...
}:
let
  cfg = config.todoist;
in
{
  options = {
    todoist = {
      enable = lib.mkEnableOption "Enable todoist";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "todoist-app"
      ];
    };
  };
}
