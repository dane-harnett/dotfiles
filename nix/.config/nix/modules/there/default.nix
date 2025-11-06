{
  config,
  lib,
  ...
}:
let
  cfg = config.there;
in
{
  options = {
    there = {
      enable = lib.mkEnableOption "Enable there";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "there"
      ];
    };
  };
}
