{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.atuin;
in
{
  options = {
    atuin = {
      enable = lib.mkEnableOption "Enable atuin";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.atuin
    ];
  };
}
