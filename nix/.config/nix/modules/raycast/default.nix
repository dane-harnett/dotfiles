{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.raycast;
in {
  options = {
    raycast = {
      enable = lib.mkEnableOption "Enable raycast";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.raycast
    ];
  };
}
