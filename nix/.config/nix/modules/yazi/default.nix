{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.yazi;
in
{
  options = {
    yazi = {
      enable = lib.mkEnableOption "Enable yazi";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.yazi
    ];
  };
}
