{
  config,
  lib,
  ...
}:
let
  cfg = config.codex;
in
{
  options = {
    codex = {
      enable = lib.mkEnableOption "Enable codex";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "codex"
      ];
    };
  };
}
