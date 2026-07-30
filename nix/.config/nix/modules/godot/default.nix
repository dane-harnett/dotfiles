{
  config,
  lib,
  ...
}:
let
  cfg = config.godot;
in
{
  options = {
    godot = {
      enable = lib.mkEnableOption "Enable godot";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "godot"
      ];
    };
  };
}
