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
    antidote = {
      enable = lib.mkEnableOption "Enable atuin";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.atuin
    ];
  };
}
