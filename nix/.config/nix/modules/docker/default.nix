{
  config,
  lib,
  ...
}:
let
  cfg = config.docker;
in
{
  options = {
    docker = {
      enable = lib.mkEnableOption "Enable Docker Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "docker"
      ];
    };
  };
}
