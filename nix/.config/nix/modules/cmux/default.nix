{
  config,
  lib,
  ...
}:
let
  cfg = config.cmux;
in
{
  options = {
    cmux = {
      enable = lib.mkEnableOption "Enable cmux";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "manaflow-ai/cmux/cmux"
      ];
      taps = [
        "manaflow-ai/cmux"
      ];
    };
  };
}
