{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.cargo;
in {
  options = {
    cargo = {
      enable = lib.mkEnableOption "Enable cargo";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.cargo
    ];
  };
}
