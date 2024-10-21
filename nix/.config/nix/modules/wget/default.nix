{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.wget;
in {
  options = {
    wget = {
      enable = lib.mkEnableOption "Enable wget";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wget
    ];
  };
}
