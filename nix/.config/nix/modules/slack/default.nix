{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.slack;
in {
  options = {
    slack = {
      enable = lib.mkEnableOption "Enable slack";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.slack
    ];
  };
}
