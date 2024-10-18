{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.util-linux;
in {
  options = {
    util-linux = {
      enable = lib.mkEnableOption "Enable util-linux";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.util-linux
    ];
  };
}
