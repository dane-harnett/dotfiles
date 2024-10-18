{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.fd;
in {
  options = {
    fd = {
      enable = lib.mkEnableOption "Enable fd";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fd
    ];
  };
}
