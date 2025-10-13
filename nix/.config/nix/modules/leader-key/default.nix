{
  config,
  lib,
  ...
}:
let
  cfg = config.leader-key;
in
{
  options = {
    leader-key = {
      enable = lib.mkEnableOption "Enable leader-key";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "leader-key"
      ];
    };
  };
}
