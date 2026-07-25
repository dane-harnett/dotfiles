{
  config,
  lib,
  ...
}:
let
  cfg = config.harper;
in
{
  options = {
    harper = {
      enable = lib.mkEnableOption "Enable harper";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "harper"
      ];
    };
  };
}
